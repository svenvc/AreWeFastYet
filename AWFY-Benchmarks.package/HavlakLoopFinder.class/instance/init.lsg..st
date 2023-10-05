as yet unclassified
init: aCfg lsg: aLsg

    cfg := aCfg.
    lsg := aLsg.
    
    nonBackPreds := Vector new.
    backPreds    := Vector new.
    number := SomIdentityDictionary new.

    maxSize := 0.
