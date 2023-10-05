as yet unclassified
removeFirst

    self isEmpty ifTrue: [ ^ nil ].
    first := first + 1.
    ^ storage at: first - 1
