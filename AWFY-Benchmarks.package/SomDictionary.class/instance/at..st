as yet unclassified
at: aKey

    | hash e |
    hash := self hash: aKey.
    e    := self bucket: hash.
  
    [ e notNil ] whileTrue: [
      (e match: hash key: aKey)
        ifTrue: [ ^ e value ].
      e := e next ].
    ^ nil
