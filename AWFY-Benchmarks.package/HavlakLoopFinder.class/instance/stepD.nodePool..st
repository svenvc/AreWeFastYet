as yet unclassified
stepD: w nodePool: nodePool

    (backPreds at: w) forEach: [:v |
      v ~= w ifTrue: [ nodePool append: (nodes at: v) findSet ]
             ifFalse: [ type at: w put: #BBSelf ] ]
