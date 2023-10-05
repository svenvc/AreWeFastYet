patterns
keywordMessage: superSend
	| kw sel |
	kw := ReadWriteStream on: String new.
	
	[ kw nextPutAll: self keyword.
	  self formula.
	] doWhileTrue: [sym == #keyword].

	sel := kw contents asSymbol