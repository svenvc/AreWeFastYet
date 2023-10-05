compiler
load: aFileName
	| sourceStream parser |
	sourceStream := self sourceOfClassFile: aFileName.
	parser := SomClassParser on: sourceStream.
	^ parser start