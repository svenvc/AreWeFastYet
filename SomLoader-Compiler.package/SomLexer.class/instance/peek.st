lexing
peek
	| oldSym oldSymChr oldText oldPrevStream |
	peekDone
		ifTrue: [ Error signal: 'SOM Lexer: cannot peek twice!' ].
	
	oldSym    := sym.
	oldSymChr := symChr.
	oldText   := ReadWriteStream with: text contents.
	oldPrevStream := prevStreamPosition.
	
	nextSym   := self symbol.
	nextSymChr:= symChr.
	nextText  := text.
	
	sym   := oldSym.
	symChr:= oldSymChr.
	text  := oldText.
	
	peekDone := true.
	
	prevStreamPosition := oldPrevStream.
	^ nextSym.