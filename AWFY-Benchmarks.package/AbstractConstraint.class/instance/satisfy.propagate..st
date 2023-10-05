as yet unclassified
satisfy: mark propagate: planner

    "Attempt to find a way to enforce this (still unsatisfied) constraint.
     If successful, record the solution, perhaps modifying the current
     dataflow graph.  Answer the constraint that this constraint overrides,
     if there is one, or nil, if there isn't."

    | overridden |
    self chooseMethod: mark.
    self isSatisfied
        ifTrue:         "constraint can be satisfied"
            ["mark inputs to allow cycle detection in addPropagate"
             | out |
             self inputsDo: [: in | in mark: mark].
             out := self output.
             overridden := out determinedBy.
             (overridden == nil) ifFalse: [overridden markUnsatisfied].
             out determinedBy: self.
             (planner addPropagate: self mark: mark) ifFalse:
                [self error: 'Cycle encountered adding:\tConstraint removed.'.
                 ^nil].
             out mark: mark]
        ifFalse:            "constraint cannot be satisfied"
            [overridden := nil.
             (strength sameAs: (Strength required)) ifTrue:
                [self error: 'Failed to satisfy a required constraint']].
    ^ overridden
