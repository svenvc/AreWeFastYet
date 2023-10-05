as yet unclassified
doDFS: currentNode current: current

    | lastId outerBlocks |
    
    (nodes at: current) initNode: currentNode dfs: current.
    number at: currentNode put: current.
    
    lastId := current.
    outerBlocks := currentNode outEdges.
    
    1 to: outerBlocks size do: [:i |
      | target |
      target := outerBlocks at: i.
      (number at: target) = self Unvisited ifTrue: [
        lastId := self doDFS: target current: lastId + 1 ] ].
    
    last at: current put: lastId.
    ^ lastId
