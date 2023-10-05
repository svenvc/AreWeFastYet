as yet unclassified
destroyConstraint: planner

    "Deactivate this constraint, remove it from the constraint graph,
     possibly causing other constraints to be satisfied, and destroy it."

    self isSatisfied ifTrue: [planner incrementalRemove: self].
    self removeFromGraph.
