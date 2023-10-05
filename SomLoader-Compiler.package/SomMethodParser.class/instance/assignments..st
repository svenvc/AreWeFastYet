patterns
assignments: vars
	self symIsIdentifier ifTrue: [
		| var nextSym |
		var := self assignment.
		
		nextSym := self peek.
		nextSym == #assign ifTrue: [
			self assignments: vars.
		].
	
		vars add: var ]