instance creation
with: lexer sym: sym text: text
	| parser |
	parser := self new.
	parser lexer: lexer sym: sym text: text.
	^ parser