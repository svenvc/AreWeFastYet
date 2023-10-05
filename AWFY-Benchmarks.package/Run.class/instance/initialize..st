as yet unclassified
initialize: aName

    name            := aName.
    benchmarkSuite  := self loadBenchmarkSuite: aName.
    total           := 0.
    numIterations   := 1.
    innerIterations := 1.
