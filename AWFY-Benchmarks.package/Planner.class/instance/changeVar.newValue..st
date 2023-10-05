as yet unclassified
changeVar: aVariable newValue: newValue

    | editConstraint plan |
    editConstraint := EditConstraint var: aVariable strength: Strength SymPreferred addTo: self.
    plan := self extractPlanFromConstraints: (Vector with: editConstraint).
    10 timesRepeat: [
      aVariable value: newValue.
      plan execute ].
    editConstraint destroyConstraint: self.
