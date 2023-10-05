as yet unclassified
values

    | values |
    values := Vector new: size_.
    buckets do: [:b |
      | current |
      current := b.
      [ current notNil ] whileTrue: [
        values append: current value.
        current := current next ] ].
    ^ values
