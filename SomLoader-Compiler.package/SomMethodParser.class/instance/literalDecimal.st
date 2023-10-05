patterns
literalDecimal
	sym == #integer ifTrue: [ ^ self literalInteger ].
	[ sym == #double ] assert.
	^ self literalDouble.