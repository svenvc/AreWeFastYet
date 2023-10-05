as yet unclassified
treeMinimum: x

    | current |
    current := x.
    [ current left notNil ] whileTrue: [
      current := current left ].
    ^ current
