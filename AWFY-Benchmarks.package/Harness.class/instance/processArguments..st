as yet unclassified
processArguments: args

    | run |
    "First argument is the Harness"
    run := Run new: (args at: 2).

    args size > 2 ifTrue: [
      run numIterations: (args at: 3) asInteger.
      args size > 3 ifTrue: [
        run innerIterations: (args at: 4) asInteger.
    ] ].
    ^ run
