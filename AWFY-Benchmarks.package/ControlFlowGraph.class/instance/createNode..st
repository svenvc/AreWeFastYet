as yet unclassified
createNode: name

    | node |

    (basicBlockMap at: name) notNil
      ifTrue:  [ node := basicBlockMap at: name ]
      ifFalse: [
        node := BasicBlock new: name.
        basicBlockMap at: name put: node ].
      
    self numNodes = 1 ifTrue: [startNode := node].
    ^ node 