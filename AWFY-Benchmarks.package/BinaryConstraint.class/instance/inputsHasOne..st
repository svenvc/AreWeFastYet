as yet unclassified
inputsHasOne: aBlock

    ^ direction = #forward
        ifTrue:  [ aBlock value: v1 ]
        ifFalse: [ aBlock value: v2 ]
