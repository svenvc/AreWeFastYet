as yet unclassified
remove: key

    | x y z xParent |
    z := self findNode: key.
    z isNil ifTrue: [ ^ nil ].

    "Y is the node to be unlinked from the tree."
    (z left isNil or: [ z right isNil ])
      ifTrue:  [ y := z ]
      ifFalse: [ y := z successor ].

    "Y is guaranteed to be non-null at this point."
    y left notNil
      ifTrue:  [ x := y left ]
      ifFalse: [ x := y right ].

    "X is the child of y which might potentially replace y in the tree.
     X might be null at this point."
    x notNil
      ifTrue: [
        x parent: y parent.
        xParent := x parent ]
      ifFalse: [
        xParent := y parent ].

    y parent isNil
      ifTrue:  [ root := x ]
      ifFalse: [
        y == y parent left
          ifTrue:  [ y parent left: x ]
          ifFalse: [ y parent right: x ] ].

    y ~= z ifTrue: [
      y color = #black ifTrue: [
        self remove: x andFixup: xParent ].

      y parent: z parent.
      y color:  z color.
      y left:   z left.
      y right:  z right.

      z left notNil ifTrue: [
        z left parent: y ].
      x right notNil ifTrue: [
        z right parent: y ].

      z parent notNil
        ifTrue: [
          z parent left == z
            ifTrue:  [ z parent left: y ]
            ifFalse: [ z parent right: y ] ]
        ifFalse: [ root := y ] ]
      ifFalse: [
        y color = #black ifTrue: [
          self remove: x andFixup: xParent ] ].

    ^ z value
