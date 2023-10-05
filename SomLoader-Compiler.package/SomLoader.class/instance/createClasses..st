actions
createClasses: classes
	| postPoned |
	postPoned := OrderedCollection new.
	classes do: [:c |
		(Smalltalk hasClassNamed: c superName)
			ifTrue: [
				| instVars classVars superCls |
				superCls := Smalltalk classNamed: c superName.
				instVars := self varString: c instanceFields.
				classVars := self varString: c classFields.
				superCls
					subclass: c theName asSymbol 
					instanceVariableNames: instVars
					classVariableNames: classVars
					package: 'AWFY-Benchmarks' ]
			ifFalse: [ postPoned add: c ]].
	^ postPoned