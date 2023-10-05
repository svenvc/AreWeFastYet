as yet unclassified
extractPlanFromConstraints: constraints

    "Extract a plan for resatisfaction starting from the outputs of the
     given constraints, usually a set of input constraints."

    | sources |
    sources := Vector new.
    constraints forEach: [: c |
      (c isInput and: [c isSatisfied]) ifTrue: [sources append: c]].
    ^ self makePlan: sources
