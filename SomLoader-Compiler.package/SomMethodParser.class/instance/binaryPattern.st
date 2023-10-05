patterns
binaryPattern
   | sig |
	sig := self binarySelector asString.
	^ sig, ' ', self argument asString.