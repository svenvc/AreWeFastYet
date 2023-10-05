patterns
expression
	| nextSym |
	nextSym := self peek.
	nextSym == #assign
		ifTrue:  [self assignation.]
		ifFalse: [self evaluation. ]