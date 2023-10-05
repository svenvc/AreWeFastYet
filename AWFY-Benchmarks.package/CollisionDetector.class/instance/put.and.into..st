as yet unclassified
put: motion and: voxel into: voxelMap

    | array |
    array := voxelMap at: voxel.
    array isNil ifTrue: [
      array := Vector new.
      voxelMap at: voxel put: array ].
    array append: motion
