as yet unclassified
propagateFrom: v

    "The given variable has changed. Propagate new values downstream."
    | todo c |
    todo := Vector new.
    self addConstraintsConsuming: v to: todo.
    [todo isEmpty] whileFalse:
      [c := todo removeFirst.
       c execute.
       self addConstraintsConsuming: c output to: todo].
