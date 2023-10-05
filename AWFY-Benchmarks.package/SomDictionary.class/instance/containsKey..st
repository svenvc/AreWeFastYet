as yet unclassified
containsKey: aKey

    | hash e |
    hash := self hash: aKey.
    e    := self bucket: hash.
  
    [ e notNil ] whileTrue: [
      (e match: hash key: aKey)
        ifTrue: [ ^ true ].
      e := e next ].
    ^ false
