as yet unclassified
innerBenchmarkLoop: innerIterations

    | system |
    system := NBodySystem new.
    
    1 to: innerIterations do: [:i |
      system advance: 0.01.
    ].
    
    ^ self verify: system energy for: innerIterations.
