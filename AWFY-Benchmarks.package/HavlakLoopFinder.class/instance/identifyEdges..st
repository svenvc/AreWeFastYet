as yet unclassified
identifyEdges: size

    1 to: size do: [:w |
      | nodeW |
      header at: w put: 1.
      type   at: w put: #BBNonHeader.
      
      nodeW := (nodes at: w) bb.
      nodeW isNil
        ifTrue:  [ type at: w put: #BBDead ]
        ifFalse: [ self processEdges: nodeW w: w ] ]
