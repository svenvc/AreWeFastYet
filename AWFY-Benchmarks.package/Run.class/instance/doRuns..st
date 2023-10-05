as yet unclassified
doRuns: bench

    1 to: numIterations do: [:i |
      self measure: bench
    ]
