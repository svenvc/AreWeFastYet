"
I load SOM Smalltalk into Squeak/Pharo images.
"
Class {
	#name : #SomLoader,
	#superclass : #Object,
	#instVars : [
		'classDefinitions'
	],
	#category : 'SomLoader-Compiler'
}

{ #category : #actions }
SomLoader class >> load: aDirectorName [
	^ self new load: aDirectorName; yourself
]

{ #category : #actions }
SomLoader class >> loadFile: aFileName [
	^ self new loadFile: aFileName; yourself
]

{ #category : #actions }
SomLoader >> checkClassesNotInSystem [
	| inSystem |
	inSystem := classDefinitions collect: [:c | Smalltalk hasClassNamed: c theName ].
	^ inSystem anySatisfy: [:b | b ]
]

{ #category : #actions }
SomLoader >> classDefinitions [
	^ classDefinitions
]

{ #category : #actions }
SomLoader >> createClasses [
	| postPoned |
	postPoned := classDefinitions.
	[ postPoned isEmpty ] whileFalse: [ 
		postPoned := self createClasses: postPoned ]
]

{ #category : #actions }
SomLoader >> createClasses: classes [
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
]

{ #category : #actions }
SomLoader >> createMethods [
	classDefinitions do: [:c |
		| class |
		class := Smalltalk classNamed: c theName.
		c instanceMethods do: [:methodCode |
			class compile: methodCode ].
		c classMethods do: [:methodCode |
			class class compile: methodCode ] ]
]

{ #category : #actions }
SomLoader >> load: aDirectorName [
	| dir results |
	results := OrderedCollection new.
	dir := aDirectorName asFileReference.
	dir entries do: [:e |
		e isDirectory
			ifTrue: [
				| result |
				result := self load: e fullName.
				results addAll: result ]
			ifFalse: [
				e extension = 'som' ifTrue: [
					results add: (SomCompiler new load: e fullName) ]]].
	classDefinitions := results.
	^ results
]

{ #category : #actions }
SomLoader >> loadFile: aFileName [
	| file results |
	results := OrderedCollection new.
	file := aFileName asFileReference.
	results add: (SomCompiler new load: file).
	classDefinitions := results.
	^ results
]

{ #category : #'helper methods' }
SomLoader >> varString: collectionOfSymbols [ 
	^ collectionOfSymbols inject: '' into: [:res :sym | res, ' ', sym asString ]
]
