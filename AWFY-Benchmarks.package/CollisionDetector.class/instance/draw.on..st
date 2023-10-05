as yet unclassified
draw: motion on: voxelMap

    | seen |
    seen := RedBlackTree new.
    self recurse: voxelMap seen: seen voxel: (self voxelHash: motion posOne) motion: motion
