patterns
methodBlock
	| methodSource startIdx endIdx len stream trueEndIdx |
	startIdx := lexer prevLastNonWhiteCharIdx.
	
	self expect: #newTerm.
	self blockContents.
	
	endIdx := lexer prevLastNonWhiteCharIdx - 1.
	stream := lexer stream.
	trueEndIdx := stream position.
	
	len := endIdx - startIdx.
	methodSource := String new: len.
	stream position: startIdx.
	stream readInto: methodSource startingAt: 1 count: len.
	stream position: trueEndIdx.
	self expect: #endTerm.

	^ methodSource