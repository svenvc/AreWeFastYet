lexing
matchMinusOrSeparator
	(self nextInBufIs: self seperator) ifTrue: [
		text := ReadWriteStream on: String new.
		[self currentChar == $-] whileTrue: [
			text nextPut: $-.
			self readNext.
		].
		sym := #seperator.
		^ sym.
	].

	^ self match: #minus.
	