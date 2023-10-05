as yet unclassified
initialize

    taskList    := RBObject NoTask.
    currentTask := RBObject NoTask.
    currentTaskIdentity := 0.
    taskTable   := Array new: 6 withAll: RBObject NoTask.
    layout      := 0.
    queuePacketCount := 0.
    holdCount   := 0.
