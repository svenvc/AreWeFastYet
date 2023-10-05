as yet unclassified
forEach: block

    | current |
    root isNil ifTrue: [ ^ self ].
    current := RedBlackTree treeMinimum: root.
    [ current notNil ] whileTrue: [
      block value: (RbtEntry key: current key value: current value).
      current := current successor ].
