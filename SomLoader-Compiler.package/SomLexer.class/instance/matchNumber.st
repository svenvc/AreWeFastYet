lexing
matchNumber
	| sawDecimalMark |
	sym    := #integer.
	symChr := nil.
	text   := ReadWriteStream on: String new.
	
	sawDecimalMark := false.

	[ text nextPut: self currentChar.
	  self readNext.
	  (sawDecimalMark not and: [
			self currentChar = $. and: [
				| nextChar |
				nextChar := self bufchar: bufP + 1.
				nextChar notNil and: [ nextChar isDigit]]]) ifTrue: [
					sym := #double.
					sawDecimalMark := true.
					text nextPut: self currentChar.
					self readNext ]
	] doWhileTrue: [self currentChar notNil and: [ self currentChar isDigit ]].

	^ sym