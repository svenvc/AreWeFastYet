patterns
assignment
	| v |
	v := self variable.
	self expect: #assign.	
	^ v