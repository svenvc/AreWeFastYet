as yet unclassified
simulate: time

    | frame |
    frame := Vector new.
    0 to: aircrafts size - 2 by: 2 do: [:i |
      frame append: (Aircraft new: (aircrafts at: i + 1)
                              pos: (Vector3D x: time
                                             y: (time cos * 2.0) + (i * 3.0)
                                             z: 10.0)).
      frame append: (Aircraft new: (aircrafts at: i + 2)
                              pos: (Vector3D x: time
                                             y: (time sin * 2.0) + (i * 3.0)
                                             z: 10.0)) ].
    ^ frame
