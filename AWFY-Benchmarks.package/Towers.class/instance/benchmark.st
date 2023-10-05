as yet unclassified
benchmark

    piles := Array new: 3.
    self buildTowerAt: 1 disks: 13.
    movesdone := 0.
    self move: 13 disksFrom: 1 to: 2.
    ^ movesdone
