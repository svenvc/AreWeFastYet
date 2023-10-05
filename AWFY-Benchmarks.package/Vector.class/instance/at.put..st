as yet unclassified
at: index put: val

    index > storage size ifTrue: [
      | newLength newStorage |
      newLength := storage size.
      [ newLength < index ] whileTrue: [
        newLength := newLength * 2 ].
      newStorage := Array new: newLength.
      1 to: storage size do: [:i | newStorage at: i put: (storage at: i) ].
      storage := newStorage ].

    storage at: index put: val.
    last < (index + 1) ifTrue: [
      last := index + 1 ]
