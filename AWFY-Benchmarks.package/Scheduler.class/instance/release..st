as yet unclassified
release: identity

      | t |
      t := self findTask: identity.
      RBObject NoTask == t ifTrue: [ ^ RBObject NoTask ].
      t taskHolding: false.
      t priority > currentTask priority
        ifTrue:  [ ^ t ]
        ifFalse: [ ^ currentTask ]
