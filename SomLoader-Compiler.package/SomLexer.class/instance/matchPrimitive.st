lexing
matchPrimitive
	self readNext: self primitive size.
	sym := #primitive.
	symChr := nil.
	text := ReadWriteStream with: self primitive.
	^ sym
	