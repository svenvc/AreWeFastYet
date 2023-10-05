as yet unclassified
isWaitingWithPacket
 ^ packetPending and: [taskWaiting and: [taskHolding not]] 