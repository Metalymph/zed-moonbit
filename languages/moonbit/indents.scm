; NOTE:
; These queries are an initial approximation and may need to be updated
; to match the actual MoonBit Tree-sitter grammar nodes.

(block) @indent
(match_arm) @indent
(struct_item) @indent
(enum_item) @indent
(trait_item) @indent
(impl_item) @indent
(call_expression arguments: (argument_list) @indent)
