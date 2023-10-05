patterns
literalDouble
	| val |
	val := text contents asNumber.
	self expect: #double.
	^ val