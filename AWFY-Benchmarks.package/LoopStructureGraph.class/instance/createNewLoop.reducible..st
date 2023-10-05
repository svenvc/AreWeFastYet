as yet unclassified
createNewLoop: bb reducible: isReducible

    | loop |
    loop := SimpleLoop basicBlock: bb reducible: isReducible.
    loop counter: loopCounter.
    loopCounter := loopCounter + 1.
    loops append: loop.
    ^ loop
