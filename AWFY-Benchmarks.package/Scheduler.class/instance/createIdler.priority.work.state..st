as yet unclassified
createIdler: identity priority: priority work: work state: state

      | data |
      data := IdleTaskDataRecord create.
      self createTask: identity
           priority:   priority
           work:       work
           state:      state
           function:  [:thework :word | 
             | thedata |
             thedata := word.
             thedata count: thedata count - 1.
             0 = thedata count
               ifTrue:  [ self holdSelf ]
               ifFalse: [
                 0 = (thedata control & 1 )
                 ifTrue: [
                   thedata control: thedata control // 2.
                   self release: RBObject DeviceA]
                 ifFalse: [
                   thedata control: (thedata control // 2 bitXor: 53256).
                   self release: RBObject DeviceB]]]
           data: data
