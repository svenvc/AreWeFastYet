as yet unclassified
readObject

    | object |
    self read.
    object := JsonObject new.
    self skipWhiteSpace.

    (self readChar: '}') ifTrue: [
      ^ object
    ].
    
    self readObjectKeyValuePair: object.
    [self readChar: ','] whileTrue: [
      self readObjectKeyValuePair: object.
    ].
    
    (self readChar: '}') ifFalse: [
      self expected: '"," or "}"'
    ].
    
    ^ object
