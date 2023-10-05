as yet unclassified
indexOf: name

    | idx |
    idx := table at: name.    
    (idx ~= 0 and: [name = (names at: idx)]) ifTrue: [ ^ idx ].
    ^ self error: 'not implement'
