as yet unclassified
calculateNestingLevel

    loops forEach: [:liter |
      liter isRoot ifFalse: [
        liter parent isNil ifTrue: [
          liter parent: root ] ] ].

    self calculateNestingLevelRec: root depth: 0
