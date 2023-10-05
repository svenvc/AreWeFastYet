as yet unclassified
initialize

    root  := SimpleLoop basicBlock: nil reducible: false.
    loops := Vector new.
    loopCounter := 0.
  
    root nestingLevel: 0.
    root counter: loopCounter.
    loopCounter := loopCounter + 1.
    loops append: root
