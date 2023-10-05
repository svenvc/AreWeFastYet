Class {
	#name : #SomCompiler,
	#superclass : #Object,
	#category : 'SomLoader-Compiler'
}

{ #category : #compiler }
SomCompiler >> load: aFileName [
	| sourceStream parser |
	sourceStream := self sourceOfClassFile: aFileName.
	parser := SomClassParser on: sourceStream.
	^ parser start
]

{ #category : #'file access' }
SomCompiler >> sourceOfClassFile: aFileName [
	| source |
	source := nil.
	source := aFileName asFileReference contents.
	^ source readStream
]
