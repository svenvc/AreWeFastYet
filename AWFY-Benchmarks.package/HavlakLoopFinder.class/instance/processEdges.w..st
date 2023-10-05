as yet unclassified
processEdges: nodeW w: w

    nodeW numPred > 0 ifTrue: [
      nodeW inEdges forEach: [:nodeV |
        | v |
        v := number at: nodeV.
        v ~= self Unvisited ifTrue: [
          (self isAncestor: w v: v)
            ifTrue:  [ (backPreds at: w) append: v ]
            ifFalse: [ (nonBackPreds at: w) add: v ] ] ] ]
