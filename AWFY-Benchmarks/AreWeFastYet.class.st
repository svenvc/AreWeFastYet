"
I am port of Stefan Marr's Are We Fast Yet? 's benchmarking suite.

These benchmarks were originally written in SOM, a minimal Smalltalk dialect, and loaded into Pharo using the original tools.

Usage

    AreWeFastYet run.

References

- https://github.com/smarr/are-we-fast-yet/tree/master
- http://som-st.github.io
- https://stefan-marr.de/papers/dls-marr-et-al-cross-language-compiler-benchmarking-are-we-fast-yet/
- https://rebench.stefan-marr.de

"
Class {
	#name : #AreWeFastYet,
	#superclass : #Object,
	#category : 'AWFY-Benchmarks'
}

{ #category : #accessing }
AreWeFastYet class >> run [
	"Run all 14 benchmarks in the suite, with 10 iterations. See Transcript for a report."
	
	"self run"
	
	^ self suite collect: [ :each | 
		| run |
		run := Run new: each first.
		run numIterations: 10.
		run innerIterations: each second.
		run runBenchmark ]
]

{ #category : #accessing }
AreWeFastYet class >> suite [
	"Return the 14 official benchmarks in order.
	The second argument is the number of inner iterations"
	
	^ #(
	(DeltaBlue 1)
	(Richards 1)
	(Json 1)
	(CD 10)
	(Havlak 1)
	(Bounce 1)
	(List 1)
	(Mandelbrot 1)
	(NBody 1)
	(Permute 1)
	(Queens 1)
	(Sieve 1)
	(Storage 1)
	(Towers 1)
)
]
