lexing
match: aSymbol
	sym := aSymbol.
	symChr := self currentChar.
	text := ReadWriteStream with: symChr asString.
	self readNext.
	^ sym.