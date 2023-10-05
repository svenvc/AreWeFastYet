as yet unclassified
benchmark: numAircrafts

    | numFrames simulator detector actualCollisions |
    numFrames := 200.
    
    simulator := Simulator new: numAircrafts.
    detector  := CollisionDetector new.
    
    actualCollisions := 0.
    
    0 to: numFrames - 1 do: [:i |
      | time collisions |
      time := i / 10.0.
      collisions := detector handleNewFrame: (simulator simulate: time).
      actualCollisions := actualCollisions + collisions size ].
    
    ^ actualCollisions
