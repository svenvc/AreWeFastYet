as yet unclassified
runTask

    | message |
    self isWaitingWithPacket
      ifTrue: [
        message := input.
        input := message link.
        RBObject NoWork == input
          ifTrue: [self running]
          ifFalse: [self packetPending]]
      ifFalse: [message := RBObject NoWork].
    ^ function value: message value: handle
