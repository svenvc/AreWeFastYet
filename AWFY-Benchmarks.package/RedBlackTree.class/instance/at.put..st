as yet unclassified
at: key put: value

    | insertionResult x |
    insertionResult := self treeAt: key insert: value.
    insertionResult isNewEntry ifFalse: [
      ^ insertionResult oldValue ].

    x := insertionResult newNode.

    [ x ~= root and: [ x parent color = #red ]] whileTrue: [
      x parent == x parent parent left
        ifTrue: [
          | y |
          y := x parent parent right.
          (y notNil and: [y color = #red])
            ifTrue: [
              "Case 1"
              x parent color: #black.
              y color: #black.
              x parent parent color: #red.
              x := x parent parent ]
            ifFalse: [
              x == x parent right ifTrue: [
                "Case 2"
                x := x parent.
                self leftRotate: x ].

              "Case 3"
              x parent color: #black.
              x parent parent color: #red.
              self rightRotate: x parent parent ] ]
        ifFalse: [
          "Same as 'then' clause with 'right' and 'left' exchanged"
          | y |
          y := x parent parent left.
          (y notNil and: [ y color = #red ])
            ifTrue: [
              "Case 1"
              x parent color: #black.
              y color: #black.
              x parent parent color: #red.
              x := x parent parent ]
            ifFalse: [
              x == x parent left ifTrue: [
                "Case 2"
                x := x parent.
                self rightRotate: x ].

              "Case 3"
              x parent color: #black.
              x parent parent color: #red.
              self leftRotate: x parent parent ] ] ].

    root color: #black.
    ^ nil
