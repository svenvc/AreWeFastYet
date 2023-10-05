patterns
blockArguments
	[ self expect: #colon.
	  self argument
	] doWhileTrue: [sym == #colon].