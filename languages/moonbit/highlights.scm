[
  "fn" "let" "mut" "if" "else" "match" "while" "for" "in"
  "return" "break" "continue" "struct" "enum" "trait" "type"
  "pub" "priv" "impl" "test" "package" "import" "derive" "extern"
] @keyword

(type_identifier) @type
(identifier) @variable

(boolean_literal) @boolean
(integer_literal) @number
(float_literal) @number
(double_literal) @number
(string_literal) @string
(char_literal) @string
(byte_literal) @number
(bytes_literal) @string

(comment) @comment
(block_comment) @comment

[
  "{" "}" "[" "]" "(" ")"
] @punctuation.bracket

[
  "," "." ":" ";" "::" "->" "=>"
] @punctuation.delimiter

[
  "+" "-" "*" "/" "%" "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!" "=" "+=" "-=" "*=" "/="
] @operator