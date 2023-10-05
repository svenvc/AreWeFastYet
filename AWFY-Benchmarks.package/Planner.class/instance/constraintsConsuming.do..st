as yet unclassified
constraintsConsuming: v do: aBlock

    | determiningC |
    determiningC := v determinedBy.
    v constraints forEach: [: c |
     (c == determiningC or: [c isSatisfied not]) ifFalse:
      [aBlock value: c]].
