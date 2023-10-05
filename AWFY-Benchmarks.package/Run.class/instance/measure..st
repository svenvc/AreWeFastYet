as yet unclassified
measure: bench

    | startTime endTime runTime |
    startTime := Time primUTCMicrosecondsClock.
    (bench innerBenchmarkLoop: innerIterations) ifFalse: [
      self error: 'Benchmark failed with incorrect result'. ].
    endTime   := Time primUTCMicrosecondsClock.

    runTime := endTime - startTime.
    self printResult: runTime.

    total := total + runTime.
