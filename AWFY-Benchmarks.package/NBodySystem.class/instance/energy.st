as yet unclassified
energy

    | e |
    e := 0.0.

    1 to: bodies size do: [:i |
      | iBody |
      iBody := bodies at: i.

      e := e + (0.5 * iBody mass *
           ((iBody vx * iBody vx) +
            (iBody vy * iBody vy) +
            (iBody vz * iBody vz))).

      i + 1 to: bodies size do: [:j |
          | jBody dx dy dz distance |
          jBody := bodies at: j.

          dx := iBody x - jBody x.
          dy := iBody y - jBody y.
          dz := iBody z - jBody z.

          distance := ((dx*dx) + (dy*dy) + (dz*dz)) sqrt.
          e := e - ((iBody mass * jBody mass) / distance).
      ].
    ].
    ^ e
