as yet unclassified
queuePacket: packet

    | t |
    t := self findTask: packet identity.
    RBObject NoTask == t ifTrue: [ ^ RBObject NoTask ].
    queuePacketCount := queuePacketCount + 1.
    packet link: RBObject NoWork.
    packet identity: currentTaskIdentity.
    ^ t addInput: packet checkPriority: currentTask
