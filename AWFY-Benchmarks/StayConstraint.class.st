Class {
	#name : #StayConstraint,
	#superclass : #UnaryConstraint,
	#category : 'AWFY-Benchmarks'
}

{ #category : #'as yet unclassified' }
StayConstraint class >> var: aVariable strength: strengthSymbol addTo: planner [

    "Install a stay constraint with the given strength on the given variable."

    ^ self new initializeVar: aVariable strength: strengthSymbol addTo: planner

]

{ #category : #'as yet unclassified' }
StayConstraint >> execute [


]
