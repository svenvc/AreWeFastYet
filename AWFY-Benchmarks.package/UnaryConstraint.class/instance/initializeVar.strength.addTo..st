as yet unclassified
initializeVar: aVariable strength: strengthSymbol addTo: planner

    "Initialize myself with the given variable and strength."
    super initialize: strengthSymbol.
    output := aVariable.
    satisfied := false.
    self addConstraint: planner.
