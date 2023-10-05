as yet unclassified
splitBucket: oldStorage bucket: i head: head

    | loHead loTail hiHead hiTail current |
    loHead := nil. loTail := nil.
    hiHead := nil. hiTail := nil.
    current := head.
    
    [current notNil] whileTrue: [
      (current hash & oldStorage size) = 0
        ifTrue: [
          loTail isNil
            ifTrue:  [ loHead := current ]
            ifFalse: [ loTail next: current ].
          loTail := current ]
        ifFalse: [
          hiTail isNil
            ifTrue:  [ hiHead := current ]
            ifFalse: [ hiTail next: current ].
          hiTail := current ].
      current := current next ].
  
    loTail notNil ifTrue: [
      loTail next: nil.
      buckets at: i put: loHead ].
    hiTail notNil ifTrue: [
      hiTail next: nil.
      buckets at: i + oldStorage size put: hiHead ]
