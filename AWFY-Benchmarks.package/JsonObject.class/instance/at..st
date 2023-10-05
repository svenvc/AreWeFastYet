as yet unclassified
at: name

    | idx |
    name ifNil: [ self error: 'name is null'  ].
    idx := self indexOf: name.
    idx = 0
      ifTrue:  [ ^ nil ]
      ifFalse: [ ^ values at: idx ]
