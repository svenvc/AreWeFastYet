as yet unclassified
findLoops: loopStructure

    | finder |
    finder := HavlakLoopFinder new: cfg lsg: loopStructure.
    finder findLoops
