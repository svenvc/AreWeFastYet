test
testLoadBall
	| result |
	result := SomCompiler new load: 'Ball.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 1.
	self assert: result instanceFields size equals: 4.
	self assert: result instanceMethods size equals: 2.