as yet unclassified
stepEProcessNonBackPreds: w nodePool: nodePool workList: workList x: x

    (nonBackPreds at: x dfsNumber) forEach: [:iter |
      | y ydash |
      y := nodes at: iter.
      ydash := y findSet.
      
      (self isAncestor: w v: ydash dfsNumber) not
        ifTrue: [
          type at: w put: #BBIrreducible.
          (nonBackPreds at: w) add: ydash dfsNumber ]
        ifFalse: [
          ydash dfsNumber ~= w ifTrue: [
            (nodePool hasSome: [:e | e == ydash]) ifFalse: [
              workList append: ydash.
              nodePool append: ydash ] ] ] ]
