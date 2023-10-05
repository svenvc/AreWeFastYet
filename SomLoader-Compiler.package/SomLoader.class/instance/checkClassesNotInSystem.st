actions
checkClassesNotInSystem
	| inSystem |
	inSystem := classDefinitions collect: [:c | Smalltalk hasClassNamed: c theName ].
	^ inSystem anySatisfy: [:b | b ]