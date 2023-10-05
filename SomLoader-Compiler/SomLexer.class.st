Class {
	#name : #SomLexer,
	#superclass : #Object,
	#instVars : [
		'stream',
		'text',
		'nextText',
		'lineNumber',
		'peekDone',
		'sym',
		'nextSym',
		'symChr',
		'nextSymChr',
		'buf',
		'bufP',
		'prevStreamPosition',
		'lastNonWhiteChar',
		'prevLastNonWhiteChar'
	],
	#category : 'SomLoader-Compiler'
}

{ #category : #'instance creation' }
SomLexer class >> on: aReadStream [
	| lexer |
	[aReadStream isKindOf: PositionableStream ] assert.
	
	lexer := self new.
	lexer stream: aReadStream.
	^ lexer
]

{ #category : #private }
SomLexer >> bufchar: p [
	^ p > buf size
		ifTrue:  [nil]
		ifFalse: [buf at: p]
]

{ #category : #private }
SomLexer >> currentChar [
	^ self bufchar: bufP
]

{ #category : #accessing }
SomLexer >> currentLineNumber [
	^ lineNumber
]

{ #category : #private }
SomLexer >> endOfBuffer [
	^ bufP > (buf size)
]

{ #category : #accessing }
SomLexer >> fillBuffer [
	stream atEnd ifTrue: [^ -1].
	
	buf := stream nextLine.
	buf ifNil: [^ -1].
	
	lineNumber := lineNumber + 1.
	
	bufP := 1.
	^ buf size.
]

{ #category : #private }
SomLexer >> hasMoreInput [
	self readBufferIfEmpty: [^ false].
	
	^ true
]

{ #category : #'initialize-release' }
SomLexer >> initialize [
	lineNumber := 0.
	peekDone := false.
	text := ReadWriteStream on: String new.
	buf := ''.
	bufP := 1.
]

{ #category : #helper }
SomLexer >> isOperator: char [
	^ char == $~ or: [
	  char == $& or: [
	  char == $| or: [
	  char == $* or: [
	  char == $/ or: [
	  char == $\ or: [
	  char == $+ or: [
	  char == $= or: [
	  char == $> or: [
	  char == $< or: [
	  char == $, or: [
	  char == $@ or: [
	  char == $%
	]]]]]]]]]]]].
]

{ #category : #accessing }
SomLexer >> lastNonWhiteCharIdx [
	^ lastNonWhiteChar
]

{ #category : #lexing }
SomLexer >> match: aSymbol [
	sym := aSymbol.
	symChr := self currentChar.
	text := ReadWriteStream with: symChr asString.
	self readNext.
	^ sym.
]

{ #category : #lexing }
SomLexer >> matchColonOrAssignment [
	(self bufchar: bufP + 1) == $= ifTrue: [
		sym := #assign.
		bufP := bufP + 2.
		symChr := nil.
		text := ReadWriteStream with: ':='.
		^ sym
	].

	^ self match: #colon.
]

{ #category : #lexing }
SomLexer >> matchLetter [
	symChr := nil.
	text := ReadWriteStream on: String new.
	
	[self currentChar notNil and: [
		 self currentChar isLetter or: [
		 self currentChar isDigit  or: [
		 self currentChar == $_]]]]
		whileTrue: [
			text nextPut: self currentChar.
			self readNext.
		].
	
	sym := #identifier.
	
	self currentChar == $: ifTrue: [
		sym := #keyword.
		self readNext.
		text nextPut: $:.
		
		(self currentChar notNil and: [self currentChar isLetter]) ifTrue: [
			sym := #keywordSequence.
			[self currentChar isLetter or: [self currentChar == $:]]
				whileTrue: [
					text nextPut: self currentChar.
					self readNext.
				]
		]
	].

	^ sym
]

{ #category : #lexing }
SomLexer >> matchMinusOrSeparator [
	(self nextInBufIs: self seperator) ifTrue: [
		text := ReadWriteStream on: String new.
		[self currentChar == $-] whileTrue: [
			text nextPut: $-.
			self readNext.
		].
		sym := #seperator.
		^ sym.
	].

	^ self match: #minus.
	
]

{ #category : #lexing }
SomLexer >> matchNumber [
	| sawDecimalMark |
	sym    := #integer.
	symChr := nil.
	text   := ReadWriteStream on: String new.
	
	sawDecimalMark := false.

	[ text nextPut: self currentChar.
	  self readNext.
	  (sawDecimalMark not and: [
			self currentChar = $. and: [
				| nextChar |
				nextChar := self bufchar: bufP + 1.
				nextChar notNil and: [ nextChar isDigit]]]) ifTrue: [
					sym := #double.
					sawDecimalMark := true.
					text nextPut: self currentChar.
					self readNext ]
	] doWhileTrue: [self currentChar notNil and: [ self currentChar isDigit ]].

	^ sym
]

{ #category : #lexing }
SomLexer >> matchOperator [
	| cur |
	(self isOperator: (self bufchar: bufP + 1)) ifTrue: [
		sym := #operatorSequence.
		symChr := nil.
		text := ReadWriteStream on: String new.
		
		[self isOperator: self currentChar] whileTrue: [
			text nextPut: self currentChar.
			self readNext.
		].
		^ sym.
	].

	cur := self currentChar.
	cur == $~ ifTrue: [ ^ self match: #not ].
	cur == $& ifTrue: [ ^ self match: #and ].
	cur == $| ifTrue: [ ^ self match: #or  ].
	cur == $* ifTrue: [ ^ self match: #star].
	cur == $/ ifTrue: [ ^ self match: #div ].
	cur == $\ ifTrue: [ ^ self match: #mod ].
	cur == $+ ifTrue: [ ^ self match: #plus].
	cur == $= ifTrue: [ ^ self match: #equal].
	cur == $> ifTrue: [ ^ self match: #more].
	cur == $< ifTrue: [ ^ self match: #less].
	cur == $, ifTrue: [ ^ self match: #comma].
	cur == $@ ifTrue: [ ^ self match: #at  ].
	cur == $% ifTrue: [ ^ self match: #per ].
	
	Error signal: 'STEFAN: this is unexpected, I think...'.
]

{ #category : #lexing }
SomLexer >> matchPrimitive [
	self readNext: self primitive size.
	sym := #primitive.
	symChr := nil.
	text := ReadWriteStream with: self primitive.
	^ sym
	
]

{ #category : #lexing }
SomLexer >> matchString [
	sym := #STString.
	symChr := nil.
	text := ReadWriteStream on: String new.
	
	self readNext. "skip start $' "
	[ self currentChar == $' ]
		whileFalse: [
			text nextPut: self currentChar.
			self readNext.
		].
	
	self readNext. "skip the ending $'"
	
	^ sym
]

{ #category : #helper }
SomLexer >> nextInBufIs: aString [
	| p |
	p := buf findString: aString startingAt: bufP.
	^ p == bufP
]

{ #category : #accessing }
SomLexer >> nextText [
	^ nextText asString
]

{ #category : #helper }
SomLexer >> nextWordInBufIs: aString [
   (self nextInBufIs: aString) ifTrue: [
     | nextPos nextChar |
      nextPos := bufP + aString size.
       
      nextPos > buf size ifTrue: [^true].
       
      nextChar := buf at: nextPos.
      ^ (nextChar isLetter or: [nextChar isDigit]) not.
	].

	^ false.
]

{ #category : #lexing }
SomLexer >> peek [
	| oldSym oldSymChr oldText oldPrevStream |
	peekDone
		ifTrue: [ Error signal: 'SOM Lexer: cannot peek twice!' ].
	
	oldSym    := sym.
	oldSymChr := symChr.
	oldText   := ReadWriteStream with: text contents.
	oldPrevStream := prevStreamPosition.
	
	nextSym   := self symbol.
	nextSymChr:= symChr.
	nextText  := text.
	
	sym   := oldSym.
	symChr:= oldSymChr.
	text  := oldText.
	
	peekDone := true.
	
	prevStreamPosition := oldPrevStream.
	^ nextSym.
]

{ #category : #accessing }
SomLexer >> peekDone [
	^ peekDone
]

{ #category : #accessing }
SomLexer >> prevLastNonWhiteCharIdx [
	^ prevLastNonWhiteChar
]

{ #category : #constant }
SomLexer >> primitive [
	^ 'primitive'
]

{ #category : #accessing }
SomLexer >> rawBuffer [
	^ buf
]

{ #category : #helper }
SomLexer >> readBufferIfEmpty: aBlock [
	[self endOfBuffer] whileTrue: [
		self fillBuffer == -1
			ifTrue: aBlock]
]

{ #category : #private }
SomLexer >> readNext [
	bufP := bufP + 1.
	lastNonWhiteChar := stream position - buf size + bufP.
	
]

{ #category : #helper }
SomLexer >> readNext: val [
	bufP := bufP + val.
	lastNonWhiteChar := stream position - buf size + bufP.
]

{ #category : #constant }
SomLexer >> seperator [
	^ '----'
]

{ #category : #helper }
SomLexer >> skipComment [
	self currentChar == $" ifTrue: [
		[
			self readNext.
			self readBufferIfEmpty: [^ self].
		] doWhileTrue: [self currentChar ~= $"].
		self readNext.
	].

]

{ #category : #helper }
SomLexer >> skipWhitespace [
	[self currentChar isSeparator]
		whileTrue: [
			self readNext.
			self readBufferIfEmpty: [^ self]]
]

{ #category : #helper }
SomLexer >> skipWhitespaceAndCommentsOrEnd: atEndBlock [
	[	self hasMoreInput ifFalse: atEndBlock.
		self skipWhitespace.
		self skipComment.
	] doWhileTrue: [
		self endOfBuffer 				or: [
		self currentChar isSeparator 	or: [
		self currentChar == $" ]]].
]

{ #category : #accessing }
SomLexer >> stream [
	^ stream
]

{ #category : #accessing }
SomLexer >> stream: aReadStream [
	stream := aReadStream.
]

{ #category : #lexing }
SomLexer >> symbol [
	| currentChar |
	peekDone ifTrue: [^ self symbolAfterPeek].
	prevLastNonWhiteChar := lastNonWhiteChar.
		
	self skipWhitespaceAndCommentsOrEnd: [
		sym := #none.
		symChr := nil.
		text := ReadWriteStream on: String new.
		^ sym
	].

	currentChar := self currentChar.
	
	currentChar == $' ifTrue: [ ^ self matchString ].
	currentChar == $[ ifTrue: [ ^ self match: #newBlock ].
	currentChar == $] ifTrue: [ ^ self match: #endBlock ].
	currentChar == $: ifTrue: [ ^ self matchColonOrAssignment ].
	currentChar == $( ifTrue: [ ^ self match: #newTerm ].
	currentChar == $) ifTrue: [ ^ self match: #endTerm ].
	currentChar == $# ifTrue: [ ^ self match: #pound   ].
	currentChar == $^ ifTrue: [ ^ self match: #exit    ].
	currentChar == $. ifTrue: [ ^ self match: #period  ].
	currentChar == $- ifTrue: [ ^ self matchMinusOrSeparator ].
	(self isOperator: currentChar) ifTrue: [ ^ self matchOperator ].

	(self nextWordInBufIs: self primitive) ifTrue: [ ^ self matchPrimitive ].
	
	currentChar isLetter ifTrue: [ ^ self matchLetter ].
	currentChar isDigit  ifTrue: [ ^ self matchNumber  ].
	
	"else"
	sym    := #none.
	symChr := currentChar.
	text   := ReadWriteStream with: currentChar asString.
	
	^ sym
]

{ #category : #lexing }
SomLexer >> symbolAfterPeek [
	peekDone := false.
	sym      := nextSym.
	symChr   := nextSymChr.
	text     := nextText.
	^ sym
]

{ #category : #accessing }
SomLexer >> text [
	^ text contents
]
