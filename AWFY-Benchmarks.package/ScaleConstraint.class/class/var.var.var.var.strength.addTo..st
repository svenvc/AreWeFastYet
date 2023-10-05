as yet unclassified
var: src var: scale var: offset var: dst strength: strengthSymbol addTo: planner

    "Install a scale constraint with the given strength on the given
     variables."
    ^ self new initializeSrc: src scale: scale offset: offset dst: dst strength: strengthSymbol addTo: planner
