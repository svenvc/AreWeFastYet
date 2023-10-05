as yet unclassified
reduceCollisionSet: motions

    | voxelMap result |
    voxelMap := RedBlackTree new.
    motions forEach: [:motion | self draw: motion on: voxelMap ].

    result := Vector new.
    voxelMap forEach: [:e |
      e value size > 1 ifTrue: [ result append: e value ] ].
    ^ result
