instance creation
on: readStream
	| parser |
	parser := self new.
	parser stream: readStream.
	^ parser