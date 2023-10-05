as yet unclassified
removePropagateFrom: out

    "Update the walkabout strengths and stay flags of all variables
     downstream of the given constraint. Answer a collection of unsatisfied
     constraints sorted in order of decreasing strength."

    | unsatisfied todo v |
    unsatisfied := Vector new.
        
    out determinedBy: nil.
    out walkStrength: Strength absoluteWeakest.
    out stay: true.
    todo := Vector with: out.
    [todo isEmpty] whileFalse: [
      v := todo removeFirst.
       v constraints forEach: [:c |
         c isSatisfied ifFalse: [unsatisfied append: c]].
       self constraintsConsuming: v do: [:c |
         c recalculate.
         todo append: c output]].

    unsatisfied sort: [:c1 :c2 | c1 strength stronger: c2 strength].
    ^ unsatisfied
