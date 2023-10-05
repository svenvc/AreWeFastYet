patterns
method
   | name body |
	name := self methodName.
	self expect: #equal.
	
	body := self methodBody.
	^ name, Character lf asString, body
