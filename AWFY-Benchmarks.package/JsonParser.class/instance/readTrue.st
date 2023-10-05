as yet unclassified
readTrue

    self read.
    self readRequiredChar: 'r'.
    self readRequiredChar: 'u'.
    self readRequiredChar: 'e'.
    ^ JsonLiteral TRUE
