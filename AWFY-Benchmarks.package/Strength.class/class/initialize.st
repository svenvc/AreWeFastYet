as yet unclassified
initialize

    SymAbsoluteStrongest := Sym new: 0.
    SymRequired          := Sym new: 1.
    SymStrongPreferred   := Sym new: 2.
    SymPreferred         := Sym new: 3.
    SymStrongDefault     := Sym new: 4.
    SymDefault           := Sym new: 5.
    SymWeakDefault       := Sym new: 6.
    SymAbsoluteWeakest   := Sym new: 7.
  
    StrengthTable := self createStrengthTable.
    StrengthConstants := self createStrengthConstants.

    AbsoluteStrongest := Strength of: SymAbsoluteStrongest.
    AbsoluteWeakest := Strength of: SymAbsoluteWeakest.
    Required := Strength of: SymRequired.
