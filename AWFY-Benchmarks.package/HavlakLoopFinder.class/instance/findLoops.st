as yet unclassified
findLoops

    | size |
    cfg startBasicBlock isNil ifTrue: [ ^ self ].
    
    size := cfg numNodes.
    
    nonBackPreds removeAll.
    backPreds removeAll.
    number removeAll.
    
    size > maxSize ifTrue: [
      header := Array new: size.
      type   := Array new: size.
      last   := Array new: size.
      nodes  := Array new: size.
      maxSize := size ].

    1 to: size do: [:i |
      nonBackPreds append: SomSet new.
      backPreds append: Vector new.
      nodes at: i put: UnionFindNode new ].

    self initAllNodes.
    self identifyEdges: size.
    header at: 1 put: 1.
    
    size to: 1 by: -1 do: [:w |
      | nodePool nodeW |
      nodePool := Vector new.
      nodeW := (nodes at: w) bb.
      
      nodeW notNil ifTrue: [
        | workList |
        self stepD: w nodePool: nodePool.
        
        workList := Vector new.
        nodePool forEach: [:niter | workList append: niter ].
        
        nodePool size ~= 0 ifTrue: [
          type at: w put: #BBReducible.
        ].
        
        [ workList isEmpty ] whileFalse: [
          | x nonBackSize |
          x := workList removeFirst.
          
          nonBackSize := (nonBackPreds at: x dfsNumber) size.
          nonBackSize > self MaxNonBackPreds ifTrue: [ ^ self ].
          self stepEProcessNonBackPreds: w nodePool: nodePool workList: workList x: x ].
          
        (nodePool size > 0 or: [(type at: w) = #BBSelf]) ifTrue: [
          | loop |
          loop := lsg createNewLoop: nodeW reducible: ((type at: w) ~= #BBIrreducible).
          self setLoopAttribute: w nodePool: nodePool loop: loop ] ] ]
