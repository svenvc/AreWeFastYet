as yet unclassified
init: aBB reducible: aBool

    counter    := 0.
    depthLevel := 0.

    isRoot_ := false.
    nestingLevel_ := 0.
    header  := aBB.
    isReducible := aBool.
    basicBlocks := SomIdentitySet new.
    children    := SomIdentitySet new.

    aBB notNil ifTrue: [ basicBlocks add: aBB ]
