as yet unclassified
constructSimpleCFG

    cfg createNode: 1.
    self buildBaseLoop: 1.
    cfg createNode: 2.
    BasicBlockEdge for: cfg from: 1 to:  3
