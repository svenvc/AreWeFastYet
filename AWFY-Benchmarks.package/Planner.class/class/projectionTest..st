as yet unclassified
projectionTest: n

      "This test constructs a two sets of variables related to each other by
       a simple linear transformation (scale and offset)."

      | scale offset src dst planner dests |
      planner := Planner new.
      dests   := Vector new.
      scale   := ConstrainedVariable value: 10.
      offset  := ConstrainedVariable value: 1000.

      1 to: n do: [ :i |
        src := ConstrainedVariable value: i.
        dst := ConstrainedVariable value: i.
        dests append: dst.
        StayConstraint  var: src strength: Strength SymDefault addTo: planner.
        ScaleConstraint var: src var: scale var: offset var: dst strength: Strength SymRequired addTo: planner
      ].

      planner changeVar: src newValue: 17.
      dst value ~= 1170 ifTrue: [self error: 'Projection test 1 failed!!'].

      planner changeVar: dst newValue: 1050.
      src value ~= 5 ifTrue: [self error: 'Projection test 2 failed!!'].

      planner changeVar: scale newValue: 5.
      1 to: n - 1 do: [ :i |
          (dests at: i) value ~= (i*5 + 1000)
              ifTrue: [self error: 'Projection test 3 failed!!']].

      planner changeVar: offset newValue: 2000.
      1 to: n - 1 do: [ :i |
          (dests at: i) value ~= (i*5 + 2000)
              ifTrue: [self error: 'Projection test 4 failed!!']]
