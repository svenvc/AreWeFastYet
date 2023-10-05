Class {
	#name : #SomLoaderTests,
	#superclass : #TestCase,
	#category : 'SomLoader-Tests'
}

{ #category : #'test all files' }
SomLoaderTests >> testLoadAll [
	| classes inSystem loader |
	loader := SomLoader load: '.'.
  classes := loader classDefinitions.
	
	"Test that none of the loaded classes is in the system"
	inSystem := classes collect: [:c | Smalltalk hasClassNamed: c theName ].
	self deny: (inSystem anySatisfy: [:b | b ])
]

{ #category : #test }
SomLoaderTests >> testLoadBall [
	| result |
	result := SomCompiler new load: 'Ball.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 1.
	self assert: result instanceFields size equals: 4.
	self assert: result instanceMethods size equals: 2.
]

{ #category : #test }
SomLoaderTests >> testLoadCDRedBlackTree [
	| result |
	result := SomCompiler new load: 'CD', DiskStore delimiter asString, 'RedBlackTree.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 1.
	self assert: result instanceFields size equals: 1.
	self assert: result instanceMethods size equals: 9.
]

{ #category : #test }
SomLoaderTests >> testLoadJson [
	| result |
	result := SomCompiler new load: 'Json', DiskStore delimiter asString, 'Json.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 2.
	self assert: result instanceFields size equals: 0.
	self assert: result instanceMethods size equals: 2.
]

{ #category : #test }
SomLoaderTests >> testLoadMandelbrot [
	| result |
	result := SomCompiler new load: 'Mandelbrot.som'.
	self deny: result isNil.
	self assert: result classFields size equals: 0.
	self assert: result classMethods size equals: 0.
	self assert: result instanceFields size equals: 0.
	self assert: result instanceMethods size equals: 3.
]
