file access
sourceOfClassFile: aFileName
	| source |
	source := nil.
	source := aFileName asFileReference contents.
	^ source readStream