as yet unclassified
readNull

    self read.
    self readRequiredChar: 'u'.
    self readRequiredChar: 'l'.
    self readRequiredChar: 'l'.
    ^ JsonLiteral NULL
