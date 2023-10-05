as yet unclassified
makeList: length

    (length = 0)
      ifTrue: [ ^ nil ]
      ifFalse: [
        | e |
        e := ListElement new: length.
        e next: (self makeList: (length - 1)).
        ^ e ]
