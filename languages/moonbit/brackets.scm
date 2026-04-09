; NOTE:
; These queries are an initial approximation and may need to be updated
; to match the actual MoonBit Tree-sitter grammar nodes.

(
  ["{" "[" "("] @open
  ["}" "]" ")"] @close
)
