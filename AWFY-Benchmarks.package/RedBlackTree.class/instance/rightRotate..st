as yet unclassified
rightRotate: y

    | x |
    x := y left.

    "Turn x's right subtree into y's left subtree"
    y left: x right.
    x right notNil ifTrue: [ x right parent: y ].

    "Link y's parent to x"
    x parent: y parent.
    y parent isNil
      ifTrue: [ root := x ]
      ifFalse: [
        y == y parent left
          ifTrue: [ y parent left: x ]
          ifFalse: [ y parent right: x ] ].

    x right: y.
    y parent: x.
    ^ x
