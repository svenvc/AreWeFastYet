actions
createClasses
	| postPoned |
	postPoned := classDefinitions.
	[ postPoned isEmpty ] whileFalse: [ 
		postPoned := self createClasses: postPoned ]