patterns
literalNumber
	sym == #minus	ifTrue: [self negativeDecimal]
						ifFalse:[self literalDecimal ].
