adding
addMethod: methodSource
	^ self isClassSide
		ifFalse: [self instanceMethods add: methodSource]
		ifTrue: [	self classMethods add: methodSource]