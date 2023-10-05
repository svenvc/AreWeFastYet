as yet unclassified
compare: a and: b

    a = b ifTrue: [ ^  0 ].
    a < b ifTrue: [ ^ -1 ].
    a > b ifTrue: [ ^  1 ].

    "We say that NaN is smaller than non-NaN."
    a = a ifTrue: [ ^ 1 ].
    ^ -1
