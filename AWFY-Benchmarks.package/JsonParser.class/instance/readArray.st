as yet unclassified
readArray

    | array |
    self read.
    array := JsonArray new.
    
    "Array might be empty"
    self skipWhiteSpace.
    (self readChar: ']') ifTrue: [
      ^ array
    ].
    
    self readArrayElement: array.
    [self readChar: ','] whileTrue: [
      self readArrayElement: array.
    ].

    (self readChar: ']') ifFalse: [
      self expected: '"," or "]"'
    ].
    ^ array
