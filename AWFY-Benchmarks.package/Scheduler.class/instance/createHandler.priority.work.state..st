as yet unclassified
createHandler: identity priority: priority work: work state: state

    | data |
    data := HandlerTaskDataRecord create.
    self createTask: identity
         priority:   priority
         work:       work
         state:      state
         function:   [:thework :word | 
           | thedata workPacket |
           thedata := word.
           RBObject NoWork == thework ifFalse: [
             RBObject WorkPacketKind == thework kind 
               ifTrue:  [ thedata workInAdd: thework ]
               ifFalse: [ thedata deviceInAdd: thework ]].

           RBObject NoWork == (workPacket := thedata workIn)
             ifTrue: [ self wait ]
             ifFalse: [
               | count |
               count := workPacket datum.
               count > 4
                 ifTrue: [
                   thedata workIn: workPacket link.
                   self queuePacket: workPacket]
                 ifFalse: [
                   | devicePacket |
                   RBObject NoWork == (devicePacket := thedata deviceIn)
                     ifTrue: [ self wait ]
                     ifFalse: [
                       thedata deviceIn: devicePacket link.
                       devicePacket datum: (workPacket data at: count).
                       workPacket datum: count + 1.
                       self queuePacket: devicePacket]]]]
         data: data
