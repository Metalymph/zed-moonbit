; NOTE:
; These queries are an initial approximation and may need to be updated
; to match the actual MoonBit Tree-sitter grammar nodes.

; Outline for functions
(function_item
  name: (identifier) @name) @item

; Outline for structs
(struct_item
  name: (type_identifier) @name) @item

; Outline for enums
(enum_item
  name: (type_identifier) @name) @item

; Outline for traits
(trait_item
  name: (type_identifier) @name) @item

; Outline for implementations
(impl_item
  type: (type_identifier) @name) @item
