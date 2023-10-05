as yet unclassified
link: aLink identity: anIdentity priority: aPriority initialWorkQueue: anInitialWorkQueue initialState: anInitialState function: aBlock privateData: aPrivateData

    link     := aLink.
    identity := anIdentity.
    function := aBlock.
    priority := aPriority.
    input    := anInitialWorkQueue.
    handle   := aPrivateData.
    self packetPending: anInitialState isPacketPending.
    self taskWaiting: anInitialState isTaskWaiting.
    self taskHolding: anInitialState isTaskHolding.
