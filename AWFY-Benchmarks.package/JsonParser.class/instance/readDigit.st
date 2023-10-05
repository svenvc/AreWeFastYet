as yet unclassified
readDigit

    self isDigit ifFalse: [ ^ false ].
    self read.
    ^ true
