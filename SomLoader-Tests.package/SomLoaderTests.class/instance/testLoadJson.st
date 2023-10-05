test
testLoadJson
	| result |
	result := SomCompiler new load: 'Json', DiskStore delimiter asString, 'Json.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 2.
	self assert: result instanceFields size equals: 0.
	self assert: result instanceMethods size equals: 2.