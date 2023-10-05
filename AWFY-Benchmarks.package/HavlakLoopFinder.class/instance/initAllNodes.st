as yet unclassified
initAllNodes

    cfg basicBlocks forEach: [:bb |
      number at: bb put: self Unvisited ].

    self doDFS: cfg startBasicBlock current: 1
