as yet unclassified
sort: i to: j with: sortBlock

    " Sort elements i through j of self to be non-descending according to
       sortBlock. "
    | di dij dj tt ij k l n |
    sortBlock isNil ifTrue: [ ^ self defaultSort: i to: j ].
    
    "The prefix d means the data at that index."
    (n := j + 1  - i) <= 1 ifTrue: [ ^ self ]. "Nothing to sort."
    " Sort di,dj. "
    di := storage at: i.
    dj := storage at: j.
    
    "i.e., should di precede dj?"
    (sortBlock value: di with: dj) ifFalse: [
      storage swap: i with: j.
      tt := di.
      di := dj.
      dj := tt
    ].

    n > 2 ifTrue: [ " More than two elements. "
      ij := (i + j) // 2.  " ij is the midpoint of i and j. "
      dij := storage at: ij.  " Sort di,dij,dj.  Make dij be their median. "
      (sortBlock value: di with: dij)
        ifTrue: [ " i.e. should di precede dij? "
          (sortBlock value: dij with: dj) ifFalse: [ " i.e., should dij precede dj? "
            storage swap: j with: ij.
            dij := dj]]
        ifFalse: [ " i.e. di should come after dij "
          storage swap: i with: ij.
          dij := di].
      
      n > 3 ifTrue: [
        " More than three elements.
          Find k>i and l<j such that dk,dij,dl are in reverse order.
          Swap k and l.  Repeat this procedure until k and l pass each other. "
        k := i.
        l := j.
        [ [l := l - 1.  k <= l and: [sortBlock value: dij with: (storage at: l)]]
            whileTrue.  " i.e. while dl succeeds dij "
          [k := k + 1.  k <= l and: [sortBlock value: (storage at: k) with: dij]]
            whileTrue.  " i.e. while dij succeeds dk "
          k <= l]
            whileTrue:
              [ storage swap: k with: l ].

        " Now l<k (either 1 or 2 less), and di through dl are all less than or equal to dk
          through dj.  Sort those two segments. "
        self sort: i to: l with: sortBlock.
        self sort: k to: j with: sortBlock
      ]
    ]
