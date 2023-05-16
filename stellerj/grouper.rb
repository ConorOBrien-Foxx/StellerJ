TreeNode = StellerJ::Parser::TreeNode

class StellerJ::Grouper
    Verb = Struct.new(:raw, :children) {
        Vectorizable = ["+", "-", "*", "/"]
        def vectorizable?
            Vectorizable.include? raw && children.empty?
        end

        def self.from_tree_node(node)
            head = node.value
            case head
            when Array
                raw, type = head[0]
                self.new(raw, [])
            when TreeNode
                case head.speech
                when :conjunction
                    self.new(
                        head.value[0],
                        [
                            self.from_tree_node(node.left),
                            self.from_tree_node(node.right),
                        ]
                    )
                when :adverb
                    self.new(
                        head.value[0],
                        [
                            self.from_tree_node(node.left)
                        ]
                    )
                else
                    raise "TODO: #{head.speech}"
                end
            else
                raise "Unexpected tree node head #{head.inspect}"
            end
        end
    }
    Noun = Struct.new(:raw, :children, :dtype) {
        def self.infer_dtype(raw, var_ctx)
            if raw.include? " "
                StellerJ::LLVMEmitter::JITensor
            elsif /[0-9_]/ === raw[0]
                StellerJ::LLVMEmitter::IType
            else
                raise "Unknown variable #{raw}" unless var_ctx.include? raw
                var_ctx[raw]
            end
        end

        def self.from_tree_node(node, var_ctx={})
            head = node.value
            case head
            when Array
                raw, type = head
                dtype = self.infer_dtype(raw, var_ctx)
                var_ctx[raw] = dtype
                self.new(raw, [], dtype)
            when TreeNode
                children = [ node.left, node.right ].compact.map { |node|
                    self.from_tree_node node, var_ctx
                }
                new_head = Verb.from_tree_node head
                # TODO: do better than hardcoding
                dtype = if new_head.raw == "/"
                    StellerJ::LLVMEmitter::IType
                elsif new_head.raw == "$"
                    StellerJ::LLVMEmitter::JITensor
                else
                    children[0].dtype
                end
                self.new(new_head, children, dtype)
                # case head.value
                # when Array
                #     raw, type = head.value
                #     children = [ node.left, node.right ].compact.map { |node|
                #         self.from_tree_node node, var_ctx
                #     }
                #     # TODO: make informed decisions about dtype based on raw
                #     dtype = children[0].dtype
                #     self.new(new_head, children, dtype)

                # when TreeNode
                #     # adverb/conjunction
                #     raw, type = head.value.value
                #     case type
                #     when :adverb
                #         new_head = Verb.from_tree_node head
                #         p new_head, node.left, node.right
                #         exit
                #         #raise
                #     end
                #     raise 'adverb/conjunction'
                # end
            else
                raise "Unexpected tree node head #{head.inspect}"
            end
        end
    }

    # top level statements
    VariableAssignment = Struct.new(:local, :variable, :expression)
    VerbAssignment = Struct.new(:local, :variable, :expression)
    # TODO: abstract echo into its own proper function, and allow top-level expressions
    EchoStatement = Struct.new(:expression)

    def initialize(parsed)
        @nodes = parsed
        @speech_context = {}
        @type_context = {}
        @grouped = []
    end

    def group_node(node)
        head = node.value
        @grouped << case head
        when Array
            # simple expression
            raw, type = head
            case type
            when :copula
                is_local = raw.include? "."
                name = node.left&.value&.[](0)
                raise "Malformed LHS for assignment" if name.nil?
                case node.speech
                when :verb
                    maker = VerbAssignment
                    rhs = Verb.from_tree_node node.right
                    @speech_context[name] = :verb
                when :noun
                    maker = VariableAssignment
                    rhs = Noun.from_tree_node node.right, @type_context
                    @type_context[name] = rhs.dtype
                    @speech_context[name] = :noun
                when :conjunction
                    raise "ConjunctionAssignment not supported"
                when nil
                    raise "Copula resolves to nil part of speech"
                else
                    raise "#{node.speech} is not recognized as a part of speech"
                end
                maker.new(is_local, name, rhs)
            when :comment
                return
            else
                raise head
            end
        
        when TreeNode
            # complex expression
            raw, type = head.value
            if raw == "echo"
                lhs = Noun.from_tree_node node.left, @type_context
                # @type_context[name] = ??
                EchoStatement.new(lhs)
            else
                raise "Unimplemented: Non-echo, top level expressions"
            end
        end
    end

    def group
        @nodes.each { |node|
            group_node node
        }
        @grouped
    end

    def self.group(tokens)
        grouper = self.new(tokens)
        grouper.group
    end
end
