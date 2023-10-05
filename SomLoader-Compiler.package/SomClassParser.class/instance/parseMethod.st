patterns
parseMethod
	| parser result newParserState |
	parser := SomMethodParser with: lexer sym: sym text: text.
	result := parser method.
	newParserState := parser parserState.
	sym  := newParserState first.
	text := newParserState second.

	cgenc addMethod: result.
	^ result