as yet unclassified
buildTreeDepth: depth with: random

    count := count + 1.
    ^ (depth = 1) 
        ifTrue:  [ Array new: random next % 10 + 1 ]
        ifFalse: [
          | arr |
          arr := Array new: 4.
          1 to: 4 do: [:i |
            arr at: i put: (self buildTreeDepth: depth - 1 with: random) ].
          arr ]
