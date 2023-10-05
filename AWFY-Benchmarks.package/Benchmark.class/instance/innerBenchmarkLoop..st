as yet unclassified
innerBenchmarkLoop: innerIterations

      1 to: innerIterations do: [:i |
        (self verifyResult: self benchmark) ifFalse: [ ^ false ].
      ].
      ^ true
