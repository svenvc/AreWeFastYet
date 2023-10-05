as yet unclassified
forEach: block

    first to: last - 1 do: [ :i | block value: (storage at: i) ]
