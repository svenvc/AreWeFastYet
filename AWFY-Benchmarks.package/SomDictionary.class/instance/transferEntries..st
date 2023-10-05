as yet unclassified
transferEntries: oldStorage

    1 to: oldStorage size do: [:i |
      | current |
      current := oldStorage at: i.
      current notNil ifTrue: [
        oldStorage at: i put: nil.
        current next isNil
          ifTrue: [
            buckets at: 1 + (current hash & (buckets size - 1)) put: current ]
          ifFalse: [
            self splitBucket: oldStorage bucket: i head: current ] ] ]
