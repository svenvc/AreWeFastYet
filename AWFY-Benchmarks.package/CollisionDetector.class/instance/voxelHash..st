as yet unclassified
voxelHash: position

    | xDiv yDiv x y |
    xDiv := (position x / Constants GoodVoxelSize) asInteger.
    yDiv := (position y / Constants GoodVoxelSize) asInteger.

    x := Constants GoodVoxelSize * xDiv.
    y := Constants GoodVoxelSize * yDiv.

    position x < 0 ifTrue: [ x := x - Constants GoodVoxelSize ].
    position y < 0 ifTrue: [ y := y - Constants GoodVoxelSize ].

    ^ Vector2D x: x y: y
