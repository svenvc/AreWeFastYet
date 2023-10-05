patterns
methodBody
	sym == #primitive
		ifTrue:  [ ^ self primitiveBlock ]
		ifFalse: [ ^ self methodBlock ].
