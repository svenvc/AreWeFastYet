as yet unclassified
sieve: flags size: size

    | primeCount |
    primeCount := 0.

    2 to: size do: [ :i |
      (flags at: i - 1)
        ifTrue: [
          | k |
          primeCount := primeCount + 1.
          k := i + i.
          [ k <= size ]
            whileTrue: [
              flags at: k - 1 put: false.
              k := k + i ]. ] ].
    ^ primeCount
