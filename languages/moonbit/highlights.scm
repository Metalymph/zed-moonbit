; NOTE:
; These queries are an initial approximation and may need to be updated
; to match the actual MoonBit Tree-sitter grammar nodes.

; Base keywords
[
  "fn"
  "let"
  "enum"
  "struct"
  "type"
  "trait"
  "impl"
  "pub"
  "mut"
  "match"
  "if"
  "else"
  "while"
  "for"
  "in"
  "return"
  "break"
  "continue"
] @keyword

; Types and identifiers
(type_identifier) @type
(primitive_type) @type.builtin
(identifier) @variable

; Functions
(function_item name: (identifier) @function)
(call_expression function: (identifier) @function.call)

; Literal constants
(number_literal) @number
(boolean_literal) @boolean
(string_literal) @string

; Comments
(line_comment) @comment
(block_comment) @comment

; Brackets
[
  "{" "}"
  "[" "]"
  "(" ")"
] @punctuation.bracket

; Delimiters
[
  "," "." ":" ";" "::" "->" "=>"
] @punctuation.delimiter

; Operators
[
  "+" "-" "*" "/" "%"
  "==" "!=" "<" "<=" ">" ">="
  "&&" "||" "!"
  "=" "+=" "-=" "*=" "/="
] @operator

; Struct fields
(field_identifier) @property
