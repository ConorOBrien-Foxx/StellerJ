# J expressions are inherently evaluated right-to-left
# e.g. 3 - 4 + 5  equiv.  3 - (4 + 5)

def matches_speech?(subset, match_speech)
    subset
        .map(&:speech)
        .zip(match_speech)
        .all? { |speech, to_match|
            case to_match
            when Array
                to_match.include? speech
            else
                to_match == speech
            end
        }
end

def index_subsequence(group, match_speech)
    group
        .each_cons(match_speech.size)
        .with_index.find { |subset, i|
            matches_speech?(subset, match_speech)
        }
end

def end_matches?(group, match_speech)
    group.size >= match_speech.size &&
        matches_speech?(group[-match_speech.size..-1], match_speech)
end

class StellerJ::Parser
    class TreeNode
        def initialize(value, speech, left=nil, right=nil)
            @value = value
            @speech = speech
            @left = left
            @right = right
        end
        
        attr_accessor :value, :speech, :left, :right
        
        def leaf?
            @left.nil? && @right.nil?
        end
        
        def inspect
            "TreeNode(#{@value.inspect}, #{@speech.inspect}, #{@left.inspect}, #{@right.inspect})"
        end
        
        def dump(level=0)
            indent = " " * level
            puts "#{indent}TreeNode(#{@value.inspect} @ #{@speech.inspect})"
            if @left
                puts "#{indent}left:"
                @left.dump(level + 4)
            end
            if @right
                puts "#{indent}right:"
                @right.dump(level + 4)
            end
        end
        
        def linearize
            display = TreeNode === @value ? "(#{@value.linearize})" : @value[0]
            if @left
                lval = @left.linearize
                if @right
                    rval = @right.linearize
                    rval = "(#{rval})" unless @right.leaf?
                    "#{lval}#{display}#{rval}"
                else
                    "#{lval}#{display}"
                end
            else
                display
            end
        end
        
        def dump_graphviz(level=0, node_id=1, my_id=0)
            if level.zero?
                puts "digraph G {"
                puts 'node [shape=record fontname="Consolas"];'
            end
            
            my_label = "node#{my_id}"
            label_text = case @value
            when TreeNode
                @value.linearize
            else
                @value[0]
            end
            puts "#{my_label} [label=#{label_text.inspect}]"
            
            # p @value, @left, @right
            # puts "/"*30
            
            if @left
                left_id = node_id; node_id += 1
                left_label = "node#{left_id}"
                node_id = @left.dump_graphviz(level + 1, node_id, left_id)
                puts "#{my_label} -> #{left_label}"
            end
            
            if @right
                right_id = node_id; node_id += 1
                right_label = "node#{right_id}"
                node_id = @right.dump_graphviz(level + 1, node_id, right_id) 
                puts "#{my_label} -> #{right_label}"
            end
            
            if level.zero?
                puts "}"
            end
            node_id
        end
    end

    # expects input from StellerJ::Tokenizer::tokenize
    def initialize(tokens)
        @tokens = tokens
        @op_contexts = nil
        @semantic_context = {
            "echo" => :verb,
        }
        @trees = []
    end
    
    def classify(line)
        # group nouns, verbs, adverbs, conjunctions according to part of speech
        line.map { |token|
            raw, type = token
            speech = case type
            when :data
                :noun
            when :verb, :adverb, :conjunction, :paren_start, :paren_end, :copula
                type
            when :word
                # inferring on RHS -> undefined
                @semantic_context[raw] ||= :noun
                @semantic_context[raw]
            else
                STDERR.puts "Warn: Unhandled #{token}"
            end
            TreeNode.new(token, speech)
        }
    end
    
    def structure_parens(classified)
        result = []
        build_stack = []
        classified.each { |tree|
            if tree.speech == :paren_start
                build_stack << result
                result = []
            elsif tree.speech == :paren_end
                result = build_stack.pop + [ result ]
            else
                result << tree
            end
        }
        result
    end
    
    def finalize_group(group)
        return if group.empty?
        
        if group.any? Array
            group = group.flat_map { |item|
                case item
                when Array
                    finalize_group item
                else
                    item
                end
            }
        end
        
        # TODO: finalize control structures
        # TODO: finalize direct definitions (recursively)
        # ddfn: code -> verb
        
        # collapse higher-order operators (conjunctions, adverbs)
        # scans from left to right
        loop {
            # try to resolve all possible VCV => V first
            subset, idx = index_subsequence group, [ [ :verb, :noun ], :conjunction, [ :verb, :noun ] ]
            unless idx.nil?
                v1, c, v2 = subset
                group[idx...idx + subset.size] = TreeNode.new(c, :verb, v1, v2)
                redo
            end
            # if no VCV, try VA => A
            subset, idx = index_subsequence group, [ :verb, :adverb ]
            unless idx.nil?
                v, a = subset
                group[idx...idx + subset.size] = TreeNode.new(a, :verb, v)
                redo
            end
            
            # if no VCV or VA, try N=:C | N=:A
            subset, idx = index_subsequence group, [ :noun, :copula, [ :adverb, :conjunction ] ]
            unless idx.nil?
                name, cop, conj = subset
                group[idx...idx + subset.size] = TreeNode.new(cop.value, conj.speech, name, conj)
                redo
            end
            
            # no more condensations possible
            
            break
        }
        
        # no need to condense a condensed tree
        if group.size == 1
            return group[0]
        end
        
        raise "leftover conjunction" if group.any? { |item| item.speech == :conjunction }
        raise "leftover adverb" if group.any? { |item| item.speech == :adverb }
        
        # evaluative tree condensation
        # scans from right to left
        until group.size == 1
            old_size = group.size
            if end_matches? group, [ :noun, :verb, :noun ]
                *group, n1, v, n2 = group
                group << TreeNode.new(v, :noun, n1, n2)
            elsif end_matches? group, [ :verb, :noun ]
                *group, v, n = group
                group << TreeNode.new(v, :noun, n)
            elsif end_matches? group, [ :noun, :copula, [:noun, :verb, :conjunction] ]
                *group, n1, c, n2 = group
                @semantic_context[n1.value[0]] = n2.speech
                group << TreeNode.new(c.value, n2.speech, n1, n2)
            # syntax errors
            elsif end_matches? group, [ :noun, :noun ]
                raise "syntax error: consecutive nouns"
            else
                STDERR.puts "Warn: no match for evaluative tree condensation"
                STDERR.puts "[ #{group.map(&:speech).join("; ")} ]"
            end
            raise "group size did not change" if old_size == group.size
        end
        group[0]
    end
    
    def parse_line!(line)
        return if line.empty?
        classified = classify line
        grouped = structure_parens classified
        tree = finalize_group grouped
        @trees << tree
    end
    
    def parse!
        @tokens.map! { |line|
            parse_line! line
        }
        # @trees.each { |tree|
            # tree.dump_graphviz
            # puts "-" * 70
        # }
        @trees
    end
    
    def self.parse(tokens)
        parser = self.new(tokens)
        parser.parse!
    end
end
