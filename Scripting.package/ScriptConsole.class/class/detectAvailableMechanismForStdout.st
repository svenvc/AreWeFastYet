initialization
detectAvailableMechanismForStdout
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