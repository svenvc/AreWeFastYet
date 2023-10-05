as yet unclassified
init: cfg from: fromName to: toName

    from := cfg createNode: fromName.
    to   := cfg createNode: toName.

    from addOutEdge: to.
    to   addInEdge:  from.
    cfg  addEdge:    self
