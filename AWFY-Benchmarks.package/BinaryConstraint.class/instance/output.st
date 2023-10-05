as yet unclassified
output

    "Answer my current output variable."
    (direction == #forward)
        ifTrue:  [ ^ v2 ]
        ifFalse: [ ^ v1 ]
