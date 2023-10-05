as yet unclassified
constructCFG: parLoops p: pparLoops p: ppparLoops

    | n |
    n := 3.
    
    parLoops timesRepeat: [
      cfg createNode: n + 1.
      self buildConnect: 2 end: n + 1.
      n := n + 1.
      
      pparLoops timesRepeat: [
        | top bottom |
        top := n.
        n := self buildStraight: n n:1.
        ppparLoops timesRepeat: [ n := self buildBaseLoop: n ].
        bottom := self buildStraight: n n: 1.
        self buildConnect: n end: top.
        n := bottom ].
      
      self buildConnect: n end: 1 ]
