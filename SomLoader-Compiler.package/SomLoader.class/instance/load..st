actions
load: aDirectorName
	| dir results |
	results := OrderedCollection new.
	dir := aDirectorName asFileReference.
	dir entries do: [:e |
		e isDirectory
			ifTrue: [
				| result |
				result := self load: e fullName.
				results addAll: result ]
			ifFalse: [
				e extension = 'som' ifTrue: [
					results add: (SomCompiler new load: e fullName) ]]].
	classDefinitions := results.
	^ results