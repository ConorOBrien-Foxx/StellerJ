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
        
        attr_accessor :value, :speech
        
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
            when :verb, :adverb, :conjunction, :paren_start, :paren_end
                type
            when :word
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
        
        # collapse higher-order operators (conjunctions, adverbs)
        # scans from left to right
        loop {
            # try to resolve all possible VCV => V first
            subset, idx = index_subsequence group, [ [ :verb, :noun ], :conjunction, [ :verb, :noun ] ]
            unless idx.nil?
                v1, c, v2 = subset
                group[idx..idx+2] = TreeNode.new(c.value, :verb, v1, v2)
                redo
            end
            # if no VCV, try VA => A
            subset, idx = index_subsequence group, [ :verb, :adverb ]
            unless idx.nil?
                v, a = subset
                group[idx..idx+1] = TreeNode.new(a.value, :verb, v)
                redo
            end
            # no other condensations
            raise "leftover conjunction" if group.any? { |item| item.speech == :conjunction }
            raise "leftover adverb" if group.any? { |item| item.speech == :adverb }
            break
        }
        
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
            end
            raise "group size did not change" if old_size == group.size
        end
        group[0]
    end
    
    def parse_line!(line)
        classified = classify line
        grouped = structure_parens classified
        tree = finalize_group grouped
        # TODO: infer type from copula to populate @semantic_context
        @trees << tree
    end
    
    def parse!
        @tokens.map! { |line|
            parse_line! line
        }
        @trees.each { |tree|
            tree.dump
            puts "-" * 70
        }
    end
    
    def self.parse(tokens)
        parser = self.new(tokens)
        parser.parse!
    end
end
