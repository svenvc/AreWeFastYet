lexing
symbol
	| currentChar |
	peekDone ifTrue: [^ self symbolAfterPeek].
	prevLastNonWhiteChar := lastNonWhiteChar.
		
	self skipWhitespaceAndCommentsOrEnd: [
		sym := #none.
		symChr := nil.
		text := ReadWriteStream on: String new.
		^ sym
	].

	currentChar := self currentChar.
	
	currentChar == $' ifTrue: [ ^ self matchString ].
	currentChar == $[ ifTrue: [ ^ self match: #newBlock ].
	currentChar == $] ifTrue: [ ^ self match: #endBlock ].
	currentChar == $: ifTrue: [ ^ self matchColonOrAssignment ].
	currentChar == $( ifTrue: [ ^ self match: #newTerm ].
	currentChar == $) ifTrue: [ ^ self match: #endTerm ].
	currentChar == $# ifTrue: [ ^ self match: #pound   ].
	currentChar == $^ ifTrue: [ ^ self match: #exit    ].
	currentChar == $. ifTrue: [ ^ self match: #period  ].
	currentChar == $- ifTrue: [ ^ self matchMinusOrSeparator ].
	(self isOperator: currentChar) ifTrue: [ ^ self matchOperator ].

	(self nextWordInBufIs: self primitive) ifTrue: [ ^ self matchPrimitive ].
	
	currentChar isLetter ifTrue: [ ^ self matchLetter ].
	currentChar isDigit  ifTrue: [ ^ self matchNumber  ].
	
	"else"
	sym    := #none.
	symChr := currentChar.
	text   := ReadWriteStream with: currentChar asString.
	
	^ sym