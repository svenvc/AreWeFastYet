as yet unclassified
findNode: key

    | current |
    current := root.
    [ current notNil ] whileTrue: [
      | comparisonResult |
      comparisonResult := key compareTo: current key.
      comparisonResult = 0 ifTrue: [ ^ current ].
      comparisonResult < 0
        ifTrue:  [ current := current left ]
        ifFalse: [ current := current right ] ].
    ^ nil
