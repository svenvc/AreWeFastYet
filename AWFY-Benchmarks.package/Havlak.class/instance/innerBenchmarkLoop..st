as yet unclassified
innerBenchmarkLoop: innerIterations

    ^ self verifyResult: 
       (LoopTesterApp new main: innerIterations loop: 50 p: 10 p: 10 p: 5)
      iterations: innerIterations
