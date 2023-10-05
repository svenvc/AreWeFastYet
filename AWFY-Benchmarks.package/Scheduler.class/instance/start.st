as yet unclassified
start

    | workQ |
    self
            createIdler: RBObject Idler
            priority: 0
            work: RBObject NoWork
            state: TaskState running.
    workQ := self
                            createPacket: RBObject NoWork
                            identity: RBObject Worker
                            kind: RBObject WorkPacketKind.
    workQ := self
                            createPacket: workQ
                            identity: RBObject Worker
                            kind: RBObject WorkPacketKind.
    self
            createWorker: RBObject Worker
            priority: 1000
            work: workQ
            state: TaskState waitingWithPacket.
    workQ := self
                            createPacket: RBObject NoWork
                            identity: RBObject DeviceA
                            kind: RBObject DevicePacketKind.
    workQ := self
                            createPacket: workQ
                            identity: RBObject DeviceA
                            kind: RBObject DevicePacketKind.
    workQ := self
                            createPacket: workQ
                            identity: RBObject DeviceA
                            kind: RBObject DevicePacketKind.
    self
            createHandler: RBObject HandlerA
            priority: 2000
            work: workQ
            state: TaskState waitingWithPacket.
    workQ := self
                            createPacket: RBObject NoWork
                            identity: RBObject DeviceB
                            kind: RBObject DevicePacketKind.
    workQ := self
                            createPacket: workQ
                            identity: RBObject DeviceB
                            kind: RBObject DevicePacketKind.
    workQ := self
                            createPacket: workQ
                            identity: RBObject DeviceB
                            kind: RBObject DevicePacketKind.
    self
            createHandler: RBObject HandlerB
            priority: 3000
            work: workQ
            state: TaskState waitingWithPacket.
    self
            createDevice: RBObject DeviceA
            priority: 4000
            work: RBObject NoWork
            state: TaskState waiting.
    self
            createDevice: RBObject DeviceB
            priority: 5000
            work: RBObject NoWork
            state: TaskState waiting.

    self schedule.

    ^ queuePacketCount = 23246 and: holdCount = 9297
