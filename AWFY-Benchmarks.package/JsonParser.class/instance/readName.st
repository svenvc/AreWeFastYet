as yet unclassified
readName

    current = '"' ifFalse: [ self expected: 'name' ].
    ^ self readStringInternal
