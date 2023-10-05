Class {
	#name : #SomParser,
	#superclass : #Object,
	#instVars : [
		'cgenc',
		'sym',
		'text',
		'lexer',
		'shouldReadSources'
	],
	#classVars : [
		'BinaryOpSyms',
		'KeywordSelectorSyms',
		'SingleOpSyms'
	],
	#category : 'SomLoader-Compiler'
}

{ #category : #'class initialization' }
SomParser class >> initialize [
	"self initialize"
	SingleOpSyms := #(                     not and or star div mod plus equal more less comma at per none).
	BinaryOpSyms := #(or comma minus equal not and or star div mod plus equal more less comma at per none).
	KeywordSelectorSyms := #(keyword keywordSequence).
	
]

{ #category : #'accept and expect' }
SomParser >> accept: aSymbol [
	sym == aSymbol ifTrue: [
		self getSym.
		^ true ].

	^ false
]

{ #category : #accessing }
SomParser >> cgenc [
	^ cgenc
]

{ #category : #accessing }
SomParser >> cgenc: anObject [
	cgenc := anObject
]

{ #category : #'accept and expect' }
SomParser >> expect: aSymbol [
	| msg |
	(self accept: aSymbol) ifTrue: [ ^ true ].
	
	msg := ReadWriteStream on: String new.
	msg nextPutAll: 'unexpected symbol in line '.
	msg nextPutAll: lexer currentLineNumber asString.
	msg nextPutAll: '. Expected '.
	msg nextPutAll: aSymbol asString.
	msg nextPutAll: ', but found '.
	msg nextPutAll: sym asString.
	
	self printableSymbol ifTrue: [
		msg nextPutAll: ' (', text contents, ')'.].
	
	msg nextPutAll: ': '.
	msg nextPutAll: lexer rawBuffer.
	
	Error signal: msg contents.
]

{ #category : #private }
SomParser >> getSym [
	sym  := lexer symbol.
	text := lexer text.
]

{ #category : #patterns }
SomParser >> identifier [
	| s | 
	s := text asSymbol.
	
	(self accept: #primitive) ifFalse: [
		self expect: #identifier]. 
	
	^ s
]

{ #category : #'initialize-release' }
SomParser >> initialize [
	super initialize.
	sym := #none.
	shouldReadSources := false.
]

{ #category : #private }
SomParser >> peek [
	^ lexer peek.
]

{ #category : #private }
SomParser >> printableSymbol [
	^ sym == #integer         or: [
	  sym == #STString        or: [
	  self symIsIdentifier    or: [
	  sym == #keyword         or: [
	  sym == #keywordSequence or: [
	  sym == #operatorSequence    ]]]]]
]

{ #category : #accessing }
SomParser >> shouldReadSources [
	^ shouldReadSources
]

{ #category : #accessing }
SomParser >> shouldReadSources: aBool [
	shouldReadSources := aBool
]

{ #category : #helper }
SomParser >> symIn: symbols [
	^ symbols includes: sym 
]

{ #category : #helper }
SomParser >> symIsIdentifier [
	^ sym == #identifier or: [sym == #primitive]
]

{ #category : #patterns }
SomParser >> variable [
	^ self identifier
]
