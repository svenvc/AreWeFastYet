as yet unclassified
getOne: block

    first to: last - 1 do: [ :i |
      | e |
      e := storage at: i.
      (block value: e)
        ifTrue: [ ^ e ] ].
    ^ nil
