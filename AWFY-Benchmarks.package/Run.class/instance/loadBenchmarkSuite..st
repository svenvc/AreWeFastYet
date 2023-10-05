as yet unclassified
loadBenchmarkSuite: className

    | cls |
    cls := Smalltalk classNamed: className.
    cls ifNil: [
        self error: 'Failed loading benchmark: ', className ].
    ^ cls
