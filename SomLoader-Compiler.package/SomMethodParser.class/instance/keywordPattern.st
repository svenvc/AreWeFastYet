selector patterns
keywordPattern
	| methodDef first |
	first := true.
	methodDef := ReadWriteStream on: String new.
	[ first ifTrue: [ first := false ] ifFalse: [ methodDef nextPutAll: ' ' ].
	  methodDef nextPutAll: self keyword.
	  methodDef nextPutAll: ' '.
	  methodDef nextPutAll: self argument.
	] doWhileTrue: [sym == #keyword].

	^ methodDef contents asString