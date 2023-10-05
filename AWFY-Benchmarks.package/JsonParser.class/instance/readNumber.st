as yet unclassified
readNumber

    | firstDigit |
    self startCapture.
    self readChar: '-'.
    firstDigit := current.
    
    self readDigit ifFalse: [ self expected: 'digit' ].
    firstDigit ~= '0' ifTrue: [ [self readDigit] whileTrue: []].
        
    self readFraction.
    self readExponent.
    ^ JsonNumber new: self endCapture
