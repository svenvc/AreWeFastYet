as yet unclassified
treeAt: key insert: value

    | x y z |
    y := nil.
    x := root.

    [ x notNil ] whileTrue: [
      | comparisonResult |
      y := x.
      comparisonResult := key compareTo: x key.
      comparisonResult < 0
        ifTrue:  [ x := x left ]
        ifFalse: [
          comparisonResult > 0
            ifTrue: [ x := x right ]
            ifFalse: [
              | oldValue |
              oldValue := x value.
              x value: value.
              ^ InsertResult new: false node: nil value: oldValue ] ] ].

    z := Node key: key value: value.
    z parent: y.
    y isNil
      ifTrue: [ root := z ]
      ifFalse: [
        (key compareTo: y key) < 0
          ifTrue:  [ y left: z ]
          ifFalse: [ y right: z ] ].
    
    ^ InsertResult new: true node: z value: nil
