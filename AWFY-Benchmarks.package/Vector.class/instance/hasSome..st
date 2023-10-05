as yet unclassified
hasSome: block

    first to: last - 1 do: [ :i |
      (block value: (storage at: i))
        ifTrue: [ ^ true ] ].
    ^ false
