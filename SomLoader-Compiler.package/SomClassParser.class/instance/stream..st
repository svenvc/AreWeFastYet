accessing
stream: aReadStream
	lexer := SomLexer on: aReadStream.
	self getSym.