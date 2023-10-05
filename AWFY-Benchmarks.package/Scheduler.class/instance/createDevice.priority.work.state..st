as yet unclassified
createDevice: identity priority: priority work: work state: state

    | data |
    data := DeviceTaskDataRecord create.
    self
      createTask: identity
      priority: priority
      work: work
      state: state
      function: 
        [:thework :word |
        | thedata functionWork | 
        thedata := word.
        functionWork := thework.
        RBObject NoWork == functionWork ifTrue: [
          RBObject NoWork == (functionWork := thedata pending)
            ifTrue: [ self wait ]
            ifFalse: [
              thedata pending: RBObject NoWork.
              self queuePacket: functionWork]]
          ifFalse: [
            thedata pending: functionWork.
            self tracing ifTrue: [
              self trace: functionWork datum].
            self holdSelf]]
      data: data
