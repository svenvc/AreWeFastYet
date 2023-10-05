"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAWFYBenchmarks,
	#superclass : #PackageManifest,
	#category : 'AWFY-Benchmarks-Manifest'
}

{ #category : #'code-critics' }
ManifestAWFYBenchmarks class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'AWFY-Benchmarks')) #'2023-10-05T14:33:54.924109+02:00') )
]

{ #category : #'code-critics' }
ManifestAWFYBenchmarks class >> ruleMethodSourceContainsLinefeedsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'AWFY-Benchmarks')) #'2023-10-05T14:01:16.133605+02:00') )
]

{ #category : #'code-critics' }
ManifestAWFYBenchmarks class >> ruleNoClassCommentRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'AWFY-Benchmarks')) #'2023-10-05T14:29:32.242507+02:00') )
]

{ #category : #'code-critics' }
ManifestAWFYBenchmarks class >> ruleReClassNotCategorizedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'AWFY-Benchmarks')) #'2023-10-05T14:29:27.17252+02:00') )
]
