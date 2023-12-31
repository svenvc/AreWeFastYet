Class {
	#name : #RedBlackTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : 'AWFY-Benchmarks'
}

{ #category : #'as yet unclassified' }
RedBlackTree class >> treeMinimum: x [

    | current |
    current := x.
    [ current left notNil ] whileTrue: [
      current := current left ].
    ^ current

]

{ #category : #'as yet unclassified' }
RedBlackTree >> at: key [

    | node |
    node := self findNode: key.
    node isNil ifTrue: [ ^ nil ].
    ^ node value

]

{ #category : #'as yet unclassified' }
RedBlackTree >> at: key put: value [

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

]

{ #category : #'as yet unclassified' }
RedBlackTree >> findNode: key [

    | current |
    current := root.
    [ current notNil ] whileTrue: [
      | comparisonResult |
      comparisonResult := key compareTo: current key.
      comparisonResult = 0 ifTrue: [ ^ current ].
      comparisonResult < 0
        ifTrue:  [ current := current left ]
        ifFalse: [ current := current right ] ].
    ^ nil

]

{ #category : #'as yet unclassified' }
RedBlackTree >> forEach: block [

    | current |
    root isNil ifTrue: [ ^ self ].
    current := RedBlackTree treeMinimum: root.
    [ current notNil ] whileTrue: [
      block value: (RbtEntry key: current key value: current value).
      current := current successor ].

]

{ #category : #'as yet unclassified' }
RedBlackTree >> leftRotate: x [

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

]

{ #category : #'as yet unclassified' }
RedBlackTree >> remove: key [

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

]

{ #category : #'as yet unclassified' }
RedBlackTree >> remove: anX andFixup: anXParent [

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

]

{ #category : #'as yet unclassified' }
RedBlackTree >> rightRotate: y [

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

]

{ #category : #'as yet unclassified' }
RedBlackTree >> treeAt: key insert: value [

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

]
