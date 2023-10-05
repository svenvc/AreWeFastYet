patterns
blockBody
	(self accept: #exit) ifTrue: [
		^ self result.
	].

	sym == #endBlock ifTrue: [
		^ self
	].

	sym == #endTerm ifTrue: [
		^ self
	].

	self expression.
	
	(self accept: #period) ifTrue: [
		self blockBody.
	].
