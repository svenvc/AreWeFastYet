accessing
run
	"Run all 14 benchmarks in the suite, with 10 iterations. See Transcript for a report."
	
	"self run"
	
	^ self suite collect: [ :each | 
		| run |
		run := Run new: each first.
		run numIterations: 10.
		run innerIterations: each second.
		run runBenchmark ]