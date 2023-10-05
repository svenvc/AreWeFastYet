as yet unclassified
insertBucketEntry: key value: value hash: hash head: head

    | current |
    current := head.
    
    [true] whileTrue: [
      (current match: hash key: key) ifTrue: [
        current value: value.
        ^ self ].
      current next isNil ifTrue: [
        size_ := size_ + 1.
        current next: (self newEntry: key value: value hash: hash).
        ^ self ].
      current := current next ]
