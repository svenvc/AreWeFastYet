as yet unclassified
buildBaseLoop: from

    | header diamond1 d11 diamond2 footer |
    header   := self buildStraight: from n: 1.
    diamond1 := self buildDiamond: header.
    d11      := self buildStraight: diamond1 n: 1.
    diamond2 := self buildDiamond: d11.
    footer   := self buildStraight: diamond2 n: 1.
    
    self buildConnect: diamond2 end: d11.
    self buildConnect: diamond1 end: header.
    self buildConnect: footer   end: from.
    footer := self buildStraight: footer n: 1.
    ^ footer
