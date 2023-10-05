as yet unclassified
addConstraint: planner

    "Activate this constraint and attempt to satisfy it."

    self addToGraph.
    planner incrementalAdd: self.
