as yet unclassified
keys

    | keys |
    keys := Vector new: size_.
    buckets do: [:b |
      | current |
      current := b.
      [ current notNil ] whileTrue: [
        keys append: current key.
        current := current next ] ].
    ^ keys
