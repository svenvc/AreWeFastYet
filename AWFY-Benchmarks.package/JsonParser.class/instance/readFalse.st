as yet unclassified
readFalse

    self read.
    self readRequiredChar: 'a'.
    self readRequiredChar: 'l'.
    self readRequiredChar: 's'.
    self readRequiredChar: 'e'.
    ^ JsonLiteral FALSE
