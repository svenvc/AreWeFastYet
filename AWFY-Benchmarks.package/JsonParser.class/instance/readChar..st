as yet unclassified
readChar: ch

    current = ch ifFalse: [ ^ false ].
    self read.
    ^ true
