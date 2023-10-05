as yet unclassified
createWorker: identity priority: priority work: work state: state

      | data |
      data := WorkerTaskDataRecord create.
      self createTask: identity
           priority:   priority
           work:       work
           state:      state
           function: [:thework :word |
             | thedata | 
             thedata := word.
             RBObject NoWork == thework
               ifTrue: [ self wait ]
               ifFalse: [
                 thedata destination: (RBObject HandlerA = thedata destination
                                       ifTrue:  [RBObject HandlerB]
                                       ifFalse: [RBObject HandlerA]).
                 thework identity: thedata destination.
                 thework datum: 1.
                 1 to: 4 do: [:i | 
                   thedata count: thedata count + 1.
                   thedata count > 26 ifTrue: [thedata count: 1].
                   "thework data at: i put: $A asInteger + thedata count - 1]."
                   thework data at: i put: 65 + thedata count - 1].
                 self queuePacket: thework]]
          data: data
