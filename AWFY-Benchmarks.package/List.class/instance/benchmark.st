as yet unclassified
benchmark
 | result |
    result := self
        tailWithX: (self makeList: 15)
        withY:     (self makeList: 10)
        withZ:     (self makeList: 6).
    ^ result length
