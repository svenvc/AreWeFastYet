as yet unclassified
createStrengthConstants

    | constants |
    constants := SomIdentityDictionary new.
    StrengthTable keys forEach: [:strengthSymbol |
      constants
        at: strengthSymbol
        put: (self new: strengthSymbol)].
    ^ constants
