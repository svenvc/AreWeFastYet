as yet unclassified
schedule

    currentTask := taskList. 
    [ RBObject NoTask == currentTask ] whileFalse: [
      currentTask isTaskHoldingOrWaiting
        ifTrue:  [ currentTask := currentTask link ]
        ifFalse: [
          currentTaskIdentity := currentTask identity.
          self tracing ifTrue: [ self trace: currentTaskIdentity ].
          currentTask := currentTask runTask ] ]
