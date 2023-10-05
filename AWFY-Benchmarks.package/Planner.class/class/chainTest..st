as yet unclassified
chainTest: n

      "Do chain-of-equality-constraints performance tests."
      | vars editConstraint plan planner |
      
      planner := Planner new.
      vars := Array new: n+1.
      1 to: n+1 do: [:i |
        vars at: i put: ConstrainedVariable new ].

      "thread a chain of equality constraints through the variables"
      1 to: n do: [ :i |
        | v1 v2 |
        v1 := vars at: i.
        v2 := vars at: i + 1.
        EqualityConstraint var: v1 var: v2 strength: Strength SymRequired addTo: planner].

      StayConstraint var: vars last strength: Strength SymStrongDefault addTo: planner.
      editConstraint := EditConstraint var: vars first strength: Strength SymPreferred addTo: planner.
      plan := planner extractPlanFromConstraints: (Vector with: editConstraint).

      1 to: 100 do: [ :v |
        vars first value: v.
        plan execute.
        vars last value ~= v ifTrue: [self error: 'Chain test failed!!']].

      editConstraint destroyConstraint: planner
