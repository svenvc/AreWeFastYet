as yet unclassified
run: args

    | run |
    args size < 2 ifTrue: [
      self printUsage.
      Smalltalk exit: 1
    ].
    
    run := self processArguments: args.

    run runBenchmark.
    run printTotal.
    Smalltalk exit: 0
