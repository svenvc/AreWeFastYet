patterns
literalSymbol
	| symbol |
	self expect: #pound.
	symbol := sym == #STString
		ifTrue:  [self string]
		ifFalse: [self selector].
