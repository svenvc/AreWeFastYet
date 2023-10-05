"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestScripting,
	#superclass : #PackageManifest,
	#category : 'Scripting-Manifest'
}

{ #category : #'code-critics' }
ManifestScripting class >> ruleMethodSourceContainsLinefeedsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#Scripting)) #'2023-10-05T14:17:26.372144+02:00') )
]
