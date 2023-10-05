as yet unclassified
isShorter: x than: y

    | xTail yTail |
    
    xTail := x. yTail := y.
    [ yTail isNil ]
      whileFalse: [
        xTail isNil ifTrue: [ ^ true ].
        xTail := xTail next.
        yTail := yTail next ].

    ^ false
