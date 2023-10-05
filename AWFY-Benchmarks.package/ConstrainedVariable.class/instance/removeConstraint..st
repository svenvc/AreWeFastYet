as yet unclassified
removeConstraint: c

    "Remove all traces of c from this variable."
    constraints remove: c.
    determinedBy == c ifTrue: [ determinedBy := nil ].
