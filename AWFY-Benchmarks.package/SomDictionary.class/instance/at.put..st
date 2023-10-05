as yet unclassified
at: aKey put: aVal

    | hash i current |
    hash := self hash: aKey.
    i    := self bucketIdx: hash.
    current := buckets at: i.
    
    current isNil
      ifTrue: [
        buckets at: i put: (self newEntry: aKey value: aVal hash: hash).
        size_ := size_ + 1 ]
      ifFalse: [
        self insertBucketEntry: aKey value: aVal hash: hash head: current ].

    size_ > buckets size ifTrue: [ self resize ]
