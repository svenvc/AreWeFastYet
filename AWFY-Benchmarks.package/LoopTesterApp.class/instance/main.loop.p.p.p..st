as yet unclassified
main: numDummyLoops loop: findLoopIterations p: parLoop p: pparLoops p: ppparLoops

    self constructSimpleCFG.
    self addDummyLoops: numDummyLoops.
    self constructCFG: parLoop p: pparLoops p: ppparLoops.
    
    self findLoops: lsg.
    findLoopIterations timesRepeat: [
      self findLoops: LoopStructureGraph new ].
  
    lsg calculateNestingLevel.
    ^ Array with: lsg numLoops with: cfg numNodes
