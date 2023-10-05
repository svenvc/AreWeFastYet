as yet unclassified
successor

    | x y |
    x := self.
    x right notNil ifTrue: [
      ^ RedBlackTree treeMinimum: x right ].

    y := x parent.
    [ y notNil and: [ x == y right ]] whileTrue: [
      x := y.
      y := y parent ].
    ^ y
