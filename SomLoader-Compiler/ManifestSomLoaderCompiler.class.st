"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSomLoaderCompiler,
	#superclass : #PackageManifest,
	#category : 'SomLoader-Compiler-Manifest'
}

{ #category : #'code-critics' }
ManifestSomLoaderCompiler class >> ruleMethodSourceContainsLinefeedsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'SomLoader-Compiler')) #'2023-10-05T13:36:00.775142+02:00') )
]
