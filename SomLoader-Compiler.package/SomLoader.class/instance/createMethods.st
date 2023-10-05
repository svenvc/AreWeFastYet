actions
createMethods
	classDefinitions do: [:c |
		| class |
		class := Smalltalk classNamed: c theName.
		c instanceMethods do: [:methodCode |
			class compile: methodCode ].
		c classMethods do: [:methodCode |
			class class compile: methodCode ] ]