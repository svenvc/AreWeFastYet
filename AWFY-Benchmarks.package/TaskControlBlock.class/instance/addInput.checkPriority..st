as yet unclassified
addInput: packet checkPriority: oldTask

    RBObject NoWork == input
      ifTrue: [
        input := packet.
        self packetPending: true.
        priority > oldTask priority ifTrue: [ ^ self ] ]
      ifFalse: [
        input := self append: packet head: input ].
    ^ oldTask
