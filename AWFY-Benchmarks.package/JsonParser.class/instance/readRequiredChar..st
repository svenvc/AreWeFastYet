as yet unclassified
readRequiredChar: ch

    (self readChar: ch) ifFalse: [
      self expected: 'character: ', ch
    ]
