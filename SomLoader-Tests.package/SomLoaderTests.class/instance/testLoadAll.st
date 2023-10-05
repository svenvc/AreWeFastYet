test all files
testLoadAll
	| classes inSystem loader |
	loader := SomLoader load: '.'.
  classes := loader classDefinitions.
	
	"Test that none of the loaded classes is in the system"
	inSystem := classes collect: [:c | Smalltalk hasClassNamed: c theName ].
	self deny: (inSystem anySatisfy: [:b | b ])