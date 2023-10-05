as yet unclassified
recurse: voxelMap seen: seen voxel: nextVoxel motion: motion

    (self isInVoxel: nextVoxel motion: motion) ifFalse: [ ^ self ].
    (seen at: nextVoxel put: true) = true ifTrue: [ ^ self ].

    self put: motion and: nextVoxel into: voxelMap.

    self recurse: voxelMap seen: seen voxel: (nextVoxel minus: Constants horizontal) motion: motion.
    self recurse: voxelMap seen: seen voxel: (nextVoxel plus:  Constants horizontal) motion: motion.
    self recurse: voxelMap seen: seen voxel: (nextVoxel minus: Constants vertical)   motion: motion.
    self recurse: voxelMap seen: seen voxel: (nextVoxel plus:  Constants vertical)   motion: motion.
    self recurse: voxelMap seen: seen voxel: ((nextVoxel minus: Constants horizontal) minus: Constants vertical) motion: motion.
    self recurse: voxelMap seen: seen voxel: ((nextVoxel minus: Constants horizontal) plus:  Constants vertical) motion: motion.
    self recurse: voxelMap seen: seen voxel: ((nextVoxel plus:  Constants horizontal) minus: Constants vertical) motion: motion.
    self recurse: voxelMap seen: seen voxel: ((nextVoxel plus:  Constants horizontal) plus:  Constants vertical) motion: motion.
