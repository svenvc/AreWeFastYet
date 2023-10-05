as yet unclassified
createBodies

    | px py pz bodies |

    bodies := Array new: 5.
    bodies at: 1 put: Body sun.
    bodies at: 2 put: Body jupiter.
    bodies at: 3 put: Body saturn.
    bodies at: 4 put: Body uranus.
    bodies at: 5 put: Body neptune.

    "bodies do: [:b | b print. '' println ]."

    px := 0.0.  py := 0.0.  pz := 0.0.

    bodies do: [:b |
        px := px + (b vx * b mass).
        py := py + (b vy * b mass).
        pz := pz + (b vz * b mass).
    ].

    (bodies at: 1) offsetMomentumX: px y: py z: pz.

    "bodies do: [:b | b print. '' println ]."
    ^ bodies
