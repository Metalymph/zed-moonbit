; Keywords
[
  "fn" "let" "mut" "if" "else" "match" "while" "for" "in"
  "return" "break" "continue" "struct" "enum" "trait" "type"
  "pub" "priv" "impl" "test" "package" "import" "derive" "extern"
  "const" "try" "catch" "raise" "loop" "async" "defer" "guard"
  "as" "is" "with" "not" "and" "open" "fnalias" "traitalias"
  "typealias" "letrec" "using" "readonly" "nobreak" "noraise"
] @keyword

; Type identifiers
(type_identifier) @type

; Uppercase identifiers (constructors)
(uppercase_identifier) @constructor

; Function names in definitions
(function_definition
  (function_identifier
    (lowercase_identifier) @function))

; Generic identifiers (must come after more specific rules)
(identifier) @variable

; Literals
(boolean_literal) @boolean
(integer_literal) @number
(float_literal) @number
(double_literal) @number
(string_literal) @string
(multiline_string_literal) @string
(char_literal) @string
(byte_literal) @number
(bytes_literal) @string
(escape_sequence) @string.escape
(regex_literal) @string.special

; Comments
(comment) @comment
(block_comment) @comment

; Brackets
[
  "{" "}" "[" "]" "(" ")"
] @punctuation.bracket

; Delimiters
[
  "," "." ":" ";" "::" "->" "=>"
] @punctuation.delimiter

; Operators
[
  "+" "-" "*" "/" "%" "==" "!=" "<" "<=" ">" ">=" "&&" "||" "!"
  "=" "+=" "-=" "*=" "/=" "|>"
] @operator