Class {
	#name : #SomClassParser,
	#superclass : #SomParser,
	#category : 'SomLoader-Compiler'
}

{ #category : #'instance creation' }
SomClassParser class >> on: readStream [
	| parser |
	parser := self new.
	parser stream: readStream.
	^ parser
]

{ #category : #patterns }
SomClassParser >> classBody [
	self expect: #newTerm.
	
	self classSide.
	
	self classInstanceSwitch ifTrue: [
		cgenc toggleClassSide.
		self classSide.].
	
	self expect: #endTerm.
]

{ #category : #patterns }
SomClassParser >> classInstanceSwitch [
	^ self accept: #seperator.
]

{ #category : #patterns }
SomClassParser >> classSide [
	self vars.
	
	[self symIsIdentifier     or: [
	 sym == #keyword          or: [
	 sym == #operatorSequence or: [
	 self symIn: BinaryOpSyms]]]]
		whileTrue: [
			self parseMethod].
]

{ #category : #patterns }
SomClassParser >> classStart [
	cgenc theName: self identifier.
	
	self expect: #equal.
	
	sym == #identifier
		ifTrue:  [cgenc superName: self identifier.].
		
]

{ #category : #patterns }
SomClassParser >> classdef [
	self classStart.
	self classBody.
]

{ #category : #'initialize-release' }
SomClassParser >> initialize [
	super initialize.
	
	self cgenc: SomClassGenerationContext new.
]

{ #category : #patterns }
SomClassParser >> parseMethod [
	| parser result newParserState |
	parser := SomMethodParser with: lexer sym: sym text: text.
	result := parser method.
	newParserState := parser parserState.
	sym  := newParserState first.
	text := newParserState second.

	cgenc addMethod: result.
	^ result
]

{ #category : #parsing }
SomClassParser >> start [
	self classdef.
	^ cgenc
]

{ #category : #accessing }
SomClassParser >> stream: aReadStream [
	lexer := SomLexer on: aReadStream.
	self getSym.
]

{ #category : #patterns }
SomClassParser >> vars [
	(self accept: #or) ifTrue: [
		[self symIsIdentifier] whileTrue: [
			cgenc addField: self variable.
		].
		
		self expect: #or.
	]
]
