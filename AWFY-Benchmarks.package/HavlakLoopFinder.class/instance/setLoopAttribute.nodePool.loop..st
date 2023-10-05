as yet unclassified
setLoopAttribute: w nodePool: nodePool loop: loop

    (nodes at: w) loop: loop.

    nodePool forEach: [:node |
      header at: node dfsNumber put: w.
      node union: (nodes at: w).
      
      node loop notNil
        ifTrue: [ node loop parent: loop ]
        ifFalse: [ loop addNode: node bb ] ]
