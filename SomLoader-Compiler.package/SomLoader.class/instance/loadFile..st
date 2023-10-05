actions
loadFile: aFileName
	| file results |
	results := OrderedCollection new.
	file := aFileName asFileReference.
	results add: (SomCompiler new load: file).
	classDefinitions := results.
	^ results