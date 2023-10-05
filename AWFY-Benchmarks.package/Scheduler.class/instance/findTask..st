as yet unclassified
findTask: identity

    | t |
    t := taskTable at: identity.
    RBObject NoTask == t ifTrue: [self error: 'findTask failed'].
    ^ t
