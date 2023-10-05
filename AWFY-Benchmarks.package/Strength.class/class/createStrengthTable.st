as yet unclassified
createStrengthTable

    | table |
    table := SomIdentityDictionary new.
    table at: SymAbsoluteStrongest put: -10000.
    table at: SymRequired          put: -800.
    table at: SymStrongPreferred   put: -600.
    table at: SymPreferred         put: -400.
    table at: SymStrongDefault     put: -200.
    table at: SymDefault           put: 0.
    table at: SymWeakDefault       put: 500.
    table at: SymAbsoluteWeakest   put: 10000.
    ^ table
