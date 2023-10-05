as yet unclassified
init: numAircrafts

    aircrafts := Vector new.

    0 to: numAircrafts - 1 do: [:i |
      aircrafts append: (CallSign new: i)]
