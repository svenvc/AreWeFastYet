as yet unclassified
buildDiamond: start

    | bb0 |
    bb0 := start.
    BasicBlockEdge for: cfg from: bb0 to: bb0 + 1.
    BasicBlockEdge for: cfg from: bb0 to: bb0 + 2.
    BasicBlockEdge for: cfg from: bb0 + 1 to: bb0 + 3.
    BasicBlockEdge for: cfg from: bb0 + 2 to: bb0 + 3.
    ^ bb0 + 3
