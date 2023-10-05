as yet unclassified
append: packet head: queueHead

    | mouse link |
    packet link: RBObject NoWork.
    RBObject NoWork == queueHead ifTrue: [ ^ packet ].
    mouse := queueHead.
    [RBObject NoWork == (link := mouse link)]
            whileFalse: [mouse := link].
    mouse link: packet.
    ^ queueHead
