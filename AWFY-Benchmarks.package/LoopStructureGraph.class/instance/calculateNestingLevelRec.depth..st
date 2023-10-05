as yet unclassified
calculateNestingLevelRec: loop depth: depth

    loop depthLevel: depth.
    loop children forEach: [:liter |
      self calculateNestingLevelRec: liter depth: depth + 1.
      loop nestingLevel: (loop nestingLevel max: 1 + liter nestingLevel) ]
