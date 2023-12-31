Class {
	#name : #Run,
	#superclass : #Object,
	#instVars : [
		'total',
		'numIterations',
		'innerIterations',
		'benchmarkSuite',
		'name'
	],
	#category : 'AWFY-Benchmarks'
}

{ #category : #'as yet unclassified' }
Run class >> new: aName [

    ^ self new initialize: aName

]

{ #category : #'as yet unclassified' }
Run >> benchmarkSuite: aSuite [
 benchmarkSuite  := aSuite 
]

{ #category : #'as yet unclassified' }
Run >> doRuns: bench [

    1 to: numIterations do: [:i |
      self measure: bench
    ]

]

{ #category : #'as yet unclassified' }
Run >> initialize: aName [

    name            := aName.
    benchmarkSuite  := self loadBenchmarkSuite: aName.
    total           := 0.
    numIterations   := 1.
    innerIterations := 1.

]

{ #category : #'as yet unclassified' }
Run >> innerIterations: anInt [
 innerIterations := anInt 
]

{ #category : #'as yet unclassified' }
Run >> loadBenchmarkSuite: className [

    | cls |
    cls := Smalltalk classNamed: className.
    cls ifNil: [
        self error: 'Failed loading benchmark: ', className ].
    ^ cls

]

{ #category : #'as yet unclassified' }
Run >> measure: bench [

    | startTime endTime runTime |
    startTime := Time primUTCMicrosecondsClock.
    (bench innerBenchmarkLoop: innerIterations) ifFalse: [
      self error: 'Benchmark failed with incorrect result'. ].
    endTime   := Time primUTCMicrosecondsClock.

    runTime := endTime - startTime.
    self printResult: runTime.

    total := total + runTime.

]

{ #category : #'as yet unclassified' }
Run >> name: aString [
 name := aString 
]

{ #category : #'as yet unclassified' }
Run >> numIterations: anInt [
 numIterations   := anInt 
]

{ #category : #'as yet unclassified' }
Run >> printResult: runTime [

    ScriptConsole println: (name, ': iterations=1 runtime: ', runTime asString, 'us')

]

{ #category : #'as yet unclassified' }
Run >> printTotal [

    ScriptConsole println: ('Total Runtime: ', total asString, 'us')

]

{ #category : #'as yet unclassified' }
Run >> reportBenchmark [

    ScriptConsole println: (name, ': iterations=', numIterations asString,
     ' average: ', (total // numIterations) asString, 'us total: ', total asString,
     'us').

]

{ #category : #'as yet unclassified' }
Run >> runBenchmark [

    ScriptConsole println: ('Starting ', name, ' benchmark ... ').
    
    self doRuns: benchmarkSuite new.
    self reportBenchmark.

    ScriptConsole println: ''

]
