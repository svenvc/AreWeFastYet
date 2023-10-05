as yet unclassified
tailWithX: x withY: y withZ: z

    (self isShorter: y than: x)
      ifTrue: [
        ^ (self
            tailWithX: (self tailWithX: x next withY: y withZ: z)
            withY: (self tailWithX: y next withY: z withZ: x)
            withZ: (self tailWithX: z next withY: x withZ: y)) ]
      ifFalse: [ ^ z ].
