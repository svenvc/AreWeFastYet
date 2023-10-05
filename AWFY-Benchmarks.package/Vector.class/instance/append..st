as yet unclassified
append: element

    (last > storage size) ifTrue: [
      "Need to expand capacity first"
      | newStorage |
      newStorage := Array new: (2 * storage size).
      1 to: storage size do: [:i | newStorage at: i put: (storage at: i) ].
      storage := newStorage. ].
    
    storage at: last put: element.
    last := last + 1.
    ^ self
