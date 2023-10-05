as yet unclassified
initializeSrc: srcVar scale: scaleVar offset: offsetVar dst: dstVar strength: strengthSymbol addTo: planner

    "Initialize myself with the given variables and strength."

    super initializeVar: srcVar var: dstVar strength: strengthSymbol addTo: planner.
    scale  := scaleVar.
    offset := offsetVar.

    self addConstraint: planner.
