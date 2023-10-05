as yet unclassified
compareTo: other

    ^ value = other value
        ifTrue:  [ 0 ]
        ifFalse: [
          value < other value ifTrue: [ -1 ] ifFalse: [ 1 ]]
