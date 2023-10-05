Class {
	#name : #ScriptConsole,
	#superclass : #Object,
	#classVars : [
		'LastPrintedChar',
		'OutputToTranscript',
		'Position',
		'PrintTarget'
	],
	#category : 'Scripting'
}

{ #category : #streaming }
ScriptConsole class >> << aString [
	self print: aString
]

{ #category : #printing }
ScriptConsole class >> cr [
	self println: ''.
]

{ #category : #initialization }
ScriptConsole class >> detectAvailableMechanismForStdout [
	"The preferred means is to use the stdout file handle.
	 Will try to fall back on the RoarVM primitive if necessary."
	| cls |
	(FileStream respondsTo: #stdout)
		ifTrue: [
			PrintTarget := FileStream stdout.
      PrintTarget closed ifTrue: [
        PrintTarget := FileStream standardIOStreamNamed: #stdout forWrite: true ].
			^ self.
		].
		
	cls := Smalltalk at: #RVMOperations ifAbsent: [nil].
	
	"Squeak 4.2 provides a stream at FileStream>>stdout"
	PrintTarget := Transcript.
	^ Transcript
]

{ #category : #'as yet unclassified' }
ScriptConsole class >> flush [
	PrintTarget ifNotNil: [PrintTarget flush].
]

{ #category : #initialization }
ScriptConsole class >> initialize [
	"ScriptConsole initialize"
	OutputToTranscript := false.
	self detectAvailableMechanismForStdout.
	Position := 0.
]

{ #category : #streaming }
ScriptConsole class >> nextPut: somethingAsString [
	self print: somethingAsString
]

{ #category : #streaming }
ScriptConsole class >> nextPutAll: somethingAsString [
	self print: somethingAsString
]

{ #category : #printing }
ScriptConsole class >> outputToTranscript [
	^ OutputToTranscript
]

{ #category : #printing }
ScriptConsole class >> outputToTranscript: aBool [
	OutputToTranscript := aBool
]

{ #category : #'read, write, position' }
ScriptConsole class >> peekLast [
	^ LastPrintedChar
]

{ #category : #'read, write, position' }
ScriptConsole class >> position [
	^ Position
]

{ #category : #printing }
ScriptConsole class >> print: somethingAsString [
	self print: somethingAsString withLineEnding: ''.
]

{ #category : #printing }
ScriptConsole class >> print: somethingAsString withLineEnding: lineEnd [
	"Will output the somethingAsString to stdout using one of the available mechansims and to the transcript if requested"
	| output |
	output := somethingAsString asString.
	Position := Position + output size.
	output size > 0 ifTrue: [
		LastPrintedChar := output last].
	
	PrintTarget ifNotNil: [
    "PrintTarget closed ifTrue: [ScriptConsole detectAvailableMechanismForStdout]."
		PrintTarget nextPutAll: (output, lineEnd); flush.
	].

	(OutputToTranscript or: [PrintTarget isNil])
		ifTrue: [
			Transcript show: output, lineEnd.
		].
]

{ #category : #printing }
ScriptConsole class >> println: somethingAsString [
	self print: somethingAsString withLineEnding: String cr.
]

{ #category : #printing }
ScriptConsole class >> space [
	"Append a space character to the receiver."

	self nextPut: Character space
]

{ #category : #printing }
ScriptConsole class >> tab [
	"Append a tab character to the receiver."

	self nextPut: Character tab
]
