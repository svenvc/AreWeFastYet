as yet unclassified
addConstraintsConsuming: v to: aCollection

    | determiningC |
    determiningC := v determinedBy.
    v constraints forEach: [: c |
      ((c == determiningC) or: [c isSatisfied not]) ifFalse:
        [aCollection append: c]].
