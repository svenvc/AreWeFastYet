Class {
	#name : #SomMethodParser,
	#superclass : #SomParser,
	#category : 'SomLoader-Compiler'
}

{ #category : #'instance creation' }
SomMethodParser class >> with: lexer sym: sym text: text [
	| parser |
	parser := self new.
	parser lexer: lexer sym: sym text: text.
	^ parser
]

{ #category : #'accept and expect' }
SomMethodParser >> acceptOneOf: symbols [
	(self symIn: symbols) ifTrue: [
		self getSym.
		^ true ].

	^ false
]

{ #category : #patterns }
SomMethodParser >> argument [
	^ self variable
]

{ #category : #patterns }
SomMethodParser >> assignation [
	| list |
	list := OrderedCollection new.
	self assignments: list.
	self evaluation.

]

{ #category : #patterns }
SomMethodParser >> assignment [
	| v |
	v := self variable.
	self expect: #assign.	
	^ v
]

{ #category : #patterns }
SomMethodParser >> assignments: vars [
	self symIsIdentifier ifTrue: [
		| var nextSym |
		var := self assignment.
		
		nextSym := self peek.
		nextSym == #assign ifTrue: [
			self assignments: vars.
		].
	
		vars add: var ]
]

{ #category : #patterns }
SomMethodParser >> binaryMessage: superSend [
	self binarySelector.
	self binaryOperand: false.
]

{ #category : #patterns }
SomMethodParser >> binaryOperand: superSend [
	| doSuper |
	doSuper := self primary: superSend.
	
	[self symIsIdentifier] whileTrue:
		[self unaryMessage: doSuper].
	
	^ doSuper
]

{ #category : #patterns }
SomMethodParser >> binaryPattern [
   | sig |
	sig := self binarySelector asString.
	^ sig, ' ', self argument asString.
]

{ #category : #'selector patterns' }
SomMethodParser >> binarySelector [
	| s |
	s := text asSymbol.
	
	(self accept: #or)		ifFalse: [
	(self accept: #comma)	ifFalse: [
	(self accept: #minus)	ifFalse: [
	(self accept: #equal)	ifFalse: [
	(self acceptOneOf: SingleOpSyms) ifFalse: [
	(self accept: #operatorSequence) ifFalse: [
	 self expect: #none    ]]]]]].

	^ s
]

{ #category : #patterns }
SomMethodParser >> blockArgPattern [
	| blockSig |
	sym == #colon ifTrue: [self blockPattern ].
]

{ #category : #patterns }
SomMethodParser >> blockArguments [
	[ self expect: #colon.
	  self argument
	] doWhileTrue: [sym == #colon].
]

{ #category : #patterns }
SomMethodParser >> blockBody [
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

]

{ #category : #patterns }
SomMethodParser >> blockContents [
	(self accept: #or) ifTrue: [
		self locals.
		self expect: #or.
	].

	self blockBody.
]

{ #category : #patterns }
SomMethodParser >> blockPattern [
	self blockArguments.
	self expect: #or.
]

{ #category : #patterns }
SomMethodParser >> evaluation [
	| superSend |
	superSend := self primary: false.
	
	(self symIsIdentifier     or: [
	 sym == #keyword          or: [
	 sym == #operatorSequence or: [
	 self symIn: BinaryOpSyms]]]) ifTrue: [
		self messages: superSend.
	]
]

{ #category : #'accept and expect' }
SomMethodParser >> expectOneOf: syms [
	| msg |
	(self acceptOneOf: syms)
		ifTrue: [	^ true. ].
	
	msg := ReadWriteStream on: String new.
	msg nextPutAll: 'unexpected symbol in line '.
	msg nextPutAll: lexer currentLineNumber asString.
	msg nextPutAll: '. Expected one of '.
	
	syms do: [:s | 
		msg nextPutAll: s.
		msg nextPutAll: ', '].
	
	msg nextPutAll: 'but found '.
	msg nextPutAll: sym asString.
	
	self printableSymbol ifTrue: [
		msg nextPutAll: ' (', text contents, ')'].
	
	msg nextPutAll: ': '.
	msg nextPutAll: lexer rawBuffer.
	
	Error signal: msg.
]

{ #category : #patterns }
SomMethodParser >> expression [
	| nextSym |
	nextSym := self peek.
	nextSym == #assign
		ifTrue:  [self assignation.]
		ifFalse: [self evaluation. ]
]

{ #category : #helper }
SomMethodParser >> fakeCgenc [

	cgenc := SomClassGenerationContext new
			theName: #Dummy;
			yourself.
]

{ #category : #helper }
SomMethodParser >> fakeMgenc [

	mgenc := (universe methodGenClass named: #dummy)
		somHolder: cgenc;
		yourself
]

{ #category : #patterns }
SomMethodParser >> formula [
	| superSend |
	superSend := self binaryOperand: false.
	
	(sym == #operatorSequence or: [self symIn: BinaryOpSyms])
		ifTrue: [self binaryMessage: superSend ].
	
	"only the first message in a sequence can be a super send"
	[sym == #operatorSequence or: [self symIn: BinaryOpSyms]]
		whileTrue: [self binaryMessage: false ].
]

{ #category : #patterns }
SomMethodParser >> keyword [
	| s |
	s := text.
	self expect: #keyword.
	^ s
]

{ #category : #patterns }
SomMethodParser >> keywordMessage: superSend [
	| kw sel |
	kw := ReadWriteStream on: String new.
	
	[ kw nextPutAll: self keyword.
	  self formula.
	] doWhileTrue: [sym == #keyword].

	sel := kw contents asSymbol
]

{ #category : #'selector patterns' }
SomMethodParser >> keywordPattern [
	| methodDef first |
	first := true.
	methodDef := ReadWriteStream on: String new.
	[ first ifTrue: [ first := false ] ifFalse: [ methodDef nextPutAll: ' ' ].
	  methodDef nextPutAll: self keyword.
	  methodDef nextPutAll: ' '.
	  methodDef nextPutAll: self argument.
	] doWhileTrue: [sym == #keyword].

	^ methodDef contents asString
]

{ #category : #'selector patterns' }
SomMethodParser >> keywordSelector [
	| s |
	s := text asSymbol.
	
	self expectOneOf: KeywordSelectorSyms.
	
	^ s
]

{ #category : #accessing }
SomMethodParser >> lexer: aLexer [
	lexer := aLexer
]

{ #category : #accessing }
SomMethodParser >> lexer: aLexer sym: aSym text: aText [
	lexer := aLexer.
	sym   := aSym.
	text  := aText.
]

{ #category : #patterns }
SomMethodParser >> literal [
	sym == #pound    ifTrue: [ ^ self literalSymbol. ].
	sym == #STString ifTrue: [ ^ self literalString. ].

	self literalNumber.
]

{ #category : #patterns }
SomMethodParser >> literalDecimal [
	sym == #integer ifTrue: [ ^ self literalInteger ].
	[ sym == #double ] assert.
	^ self literalDouble.
]

{ #category : #patterns }
SomMethodParser >> literalDouble [
	| val |
	val := text contents asNumber.
	self expect: #double.
	^ val
]

{ #category : #patterns }
SomMethodParser >> literalInteger [
	| val |
	val := text contents asInteger.
	self expect: #integer.
	^ val
]

{ #category : #patterns }
SomMethodParser >> literalNumber [
	sym == #minus	ifTrue: [self negativeDecimal]
						ifFalse:[self literalDecimal ].

]

{ #category : #patterns }
SomMethodParser >> literalString [
	^ self string
]

{ #category : #patterns }
SomMethodParser >> literalSymbol [
	| symbol |
	self expect: #pound.
	symbol := sym == #STString
		ifTrue:  [self string]
		ifFalse: [self selector].

]

{ #category : #patterns }
SomMethodParser >> locals [
	[self symIsIdentifier] whileTrue: [
		self variable ]
]

{ #category : #patterns }
SomMethodParser >> messages: superSend [
	| doSuper |
	doSuper := superSend.
		
	self symIsIdentifier ifTrue: [
		[ self unaryMessage: doSuper.
		  doSuper := false.
		] doWhileTrue: [self symIsIdentifier].
		
		[sym == #operatorSequence or: [self symIn: BinaryOpSyms]] whileTrue: [
			self binaryMessage: false.
		].
	
		sym == #keyword ifTrue: [
			self keywordMessage: false.
		].
		^ doSuper.
	].

	(sym == #operatorSequence or: [self symIn: BinaryOpSyms]) ifTrue: [
		[ self binaryMessage: doSuper.
		  doSuper := false.
		] doWhileTrue: [sym == #operatorSequence or: [self symIn: BinaryOpSyms]].
		
		sym == #keyword ifTrue: [
			self keywordMessage: false.
		].
		^ doSuper.
	].

	self keywordMessage: doSuper.

]

{ #category : #patterns }
SomMethodParser >> method [
   | name body |
	name := self methodName.
	self expect: #equal.
	
	body := self methodBody.
	^ name, Character lf asString, body

]

{ #category : #patterns }
SomMethodParser >> methodBlock [
	| methodSource startIdx endIdx len stream trueEndIdx |
	startIdx := lexer prevLastNonWhiteCharIdx.
	
	self expect: #newTerm.
	self blockContents.
	
	endIdx := lexer prevLastNonWhiteCharIdx - 1.
	stream := lexer stream.
	trueEndIdx := stream position.
	
	len := endIdx - startIdx.
	methodSource := String new: len.
	stream position: startIdx.
	stream readInto: methodSource startingAt: 1 count: len.
	stream position: trueEndIdx.
	self expect: #endTerm.

	^ methodSource
]

{ #category : #patterns }
SomMethodParser >> methodBody [
	sym == #primitive
		ifTrue:  [ ^ self primitiveBlock ]
		ifFalse: [ ^ self methodBlock ].

]

{ #category : #patterns }
SomMethodParser >> methodName [
	self symIsIdentifier ifTrue: [ ^ self unaryPattern   ].
	sym == #keyword      ifTrue: [ ^ self keywordPattern ].

	^ self binaryPattern.
]

{ #category : #accessing }
SomMethodParser >> mgenc [
	^ mgenc
]

{ #category : #accessing }
SomMethodParser >> mgenc: anMgenc [
	mgenc := anMgenc
]

{ #category : #patterns }
SomMethodParser >> negativeDecimal [
	self expect: #minus.
	^ self literalDecimal negated 
]

{ #category : #patterns }
SomMethodParser >> nestedBlock [
	self expect: #newBlock.
	self blockArgPattern.
	self blockContents.
	self expect: #endBlock.

]

{ #category : #patterns }
SomMethodParser >> nestedTerm [
	self expect: #newTerm.
	
	self expression.
	
	self expect: #endTerm.
]

{ #category : #patterns }
SomMethodParser >> parseNestedBlock [
	^ self nestedBlock.

]

{ #category : #accessing }
SomMethodParser >> parserState [
	^ { sym. text }
]

{ #category : #patterns }
SomMethodParser >> primary: doSuper [
	| superSend |
	superSend := doSuper.
	
	self symIsIdentifier ifTrue: [
		| v |
		v := self variable.
		v = #super ifTrue: [
			superSend := true.
		].
		^ superSend.
	].

	sym == #newTerm ifTrue: [
		self nestedTerm.
		^ superSend.
	].

	sym == #newBlock ifTrue: [
		self parseNestedBlock.
		^ superSend
	].

	self literal.
	^ superSend
]

{ #category : #patterns }
SomMethodParser >> primitiveBlock [
	self expect: #primitive.
	^ '^ Error signal: ''Primitives are not supported.'' '
]

{ #category : #patterns }
SomMethodParser >> result [
	self expression.	
	self accept: #period.
]

{ #category : #patterns }
SomMethodParser >> selector [
	(sym == #operatorSequence or: [self symIn: SingleOpSyms])
		ifTrue: [^ self binarySelector ].
	
	(sym == #keyword or: [sym == #keywordSequence])
		ifTrue: [^ self keywordSelector].
	
	^ self unarySelector
]

{ #category : #patterns }
SomMethodParser >> string [
	| s |
	s := text contents.
	self expect: #STString.
	^ s
]

{ #category : #patterns }
SomMethodParser >> unaryMessage: superSend [
	self unarySelector.

]

{ #category : #patterns }
SomMethodParser >> unaryPattern [
	^ self unarySelector asString
]

{ #category : #'selector patterns' }
SomMethodParser >> unarySelector [
	^ self identifier asSymbol
]
