as yet unclassified
at: key

    | node |
    node := self findNode: key.
    node isNil ifTrue: [ ^ nil ].
    ^ node value
