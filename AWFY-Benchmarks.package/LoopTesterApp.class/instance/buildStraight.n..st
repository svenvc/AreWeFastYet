as yet unclassified
buildStraight: start n: n

    0 to: n - 1 do: [:i |
      self buildConnect: start + i end: start + i + 1 ].
    ^ start + n
