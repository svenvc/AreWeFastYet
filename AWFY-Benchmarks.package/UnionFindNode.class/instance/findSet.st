as yet unclassified
findSet

    | nodeList node |
    nodeList := Vector new.
    
    node := self.
    
    [node ~= node parent] whileTrue: [
      ((node parent) ~= (node parent parent)) ifTrue: [
        nodeList append: node ].
      node := node parent ].
  
    nodeList forEach: [:iter | iter union: parent_ ].
    ^ node
