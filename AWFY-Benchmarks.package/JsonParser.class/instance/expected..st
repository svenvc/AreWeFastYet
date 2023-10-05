as yet unclassified
expected: expected

    self isEndOfText ifTrue: [
      self error: 'Unexpected end of input, expected ', expected asString
    ].
    self error: 'Expected ', expected
