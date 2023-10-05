as yet unclassified
handleNewFrame: frame

    | motions seen toRemove allReduced collisions |
    motions := Vector new.
    seen := RedBlackTree new.

    frame forEach: [:aircraft |
      | oldPosition newPosition |
      oldPosition := state at: aircraft callsign put: aircraft position.
      newPosition := aircraft position.
      seen at: aircraft callsign put: true.

      oldPosition isNil ifTrue: [
        "Treat newly introduced aircraft as if they were stationary"
        oldPosition := newPosition ].

      motions append: (Motion new: aircraft callsign old: oldPosition new: newPosition) ].

    " Remove aircraft that are no longer present "
    toRemove := Vector new.
    state forEach: [:e |
      (seen at: e key) ifFalse: [ toRemove append: e key ] ].

    toRemove forEach: [:e | state remove: e ].

    allReduced := self reduceCollisionSet: motions.
    collisions := Vector new.
    allReduced forEach: [:reduced |
      1 to: reduced size do: [:i |
        | motion1 |
        motion1 := reduced at: i.
        i + 1 to: reduced size do: [:j | 
          | motion2 collision |
          motion2 := reduced at: j.
          collision := motion1 findIntersection: motion2.
          collision notNil ifTrue: [
            collisions append: (Collision a: motion1 callsign b: motion2 callsign pos: collision) ] ] ] ].

    ^ collisions
