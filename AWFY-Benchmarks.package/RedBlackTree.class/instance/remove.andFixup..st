as yet unclassified
remove: anX andFixup: anXParent

    | x xParent |
    x := anX.
    xParent := anXParent.

    x ~= root and: [ x isNil or: [ x color = #black ]] whileTrue: [
      x == xParent left
        ifTrue: [
          | w |
           "Note: the text points out that w cannot be null. The reason is not obvious from
            simply looking at the code; it comes about from the properties of the red-black
            tree."
          w := xParent right.
          w color = #red ifTrue: [
            "Case 1"
            w color: #black.
            xParent color: #red.
            self leftRotate: xParent.
            w := xParent right ].
          
          ((w left isNil or: [ w left color = #black ]) and: [
            w right isNil or: [ w right color = #black ]])
            ifTrue:  [
              "Case 2"
              w color: #red.
              x := xParent.
              xParent := x parent ]
            ifFalse: [
              (w right isNil or: [ w right color = #black ]) ifTrue: [
                "Case 3"
                w left color: #black.
                w color: #red.
                self rightRotate: w.
                w := xParent right ].

              "Case 4"
              w color: xParent color.
              xParent color: #black.
              w right notNil ifTrue: [
                w right color: #black ].

              self leftRotate: xParent.
              x := root.
              xParent := x parent ] ]
        ifFalse: [
          | w |
          "Same as 'then' clause with 'right' and 'left' exchanged"
          w := xParent left.
          w color = #red ifTrue: [
            "Case 1"
            w color: #black.
            xParent color: #red.
            self rightRotate: xParent.
            w := xParent left ].

          ((w right isNil or: [ w right color = #black ]) and: [
           (w left isNil or: [ w left color = #black ])])
            ifTrue: [
              "Case 2"
              w color: #red.
              x := xParent.
              xParent := x parent ]
            ifFalse: [
              w left isNil or: [ w left color = #black ] ifTrue: [
                "Case 3"
                w right color: #black.
                w color: #red.
                self leftRotate: w.
                w := xParent left ].
              
              "Case 4"
              w color: xParent color.
              xParent color: #black.
              w left notNil ifTrue: [
                w left color: #black ].

              self rightRotate: xParent.
              x := root.
              xParent = x parent ] ] ].

    x notNil ifTrue: [ x color: #black ]
