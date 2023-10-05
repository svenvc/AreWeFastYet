as yet unclassified
leftRotate: x

    | y |
    y := x right.

    "Turn y's left subtree into x's right subtree"
    x right: y left.
    y left notNil ifTrue: [
      y left parent: x ].

    "Link x's parent to y"
    y parent: x parent.
    x parent isNil
      ifTrue: [ root := y ]
      ifFalse: [
        x == x parent left ifTrue:  [ x parent left: y ]
                           ifFalse: [ x parent right: y ] ].

    "Put x on y's left"
    y left: x.
    x parent: y.
    ^ y
