as yet unclassified
compareTo: other

    | result |
    result := self compare: x and: other x.
    result ~= 0 ifTrue: [ ^ result ].
    ^ self compare: y and: other y
