as yet unclassified
remove: object

    | newArray newLast found |
    newArray := Array new: self capacity.
    newLast := 1.
    found := false.
   
    self forEach: [ :it |
      it == object
          ifTrue:  [ found := true ]
          ifFalse: [
              newArray at: newLast put: it.
              newLast := newLast + 1 ] ].

    storage := newArray.
    last := newLast.
    first := 1.
    ^ found
