"
I represent a class that is currently parsed and I will create the final class object from this information.
"
Class {
	#name : #SomClassGenerationContext,
	#superclass : #Object,
	#instVars : [
		'superName',
		'isClassSide',
		'instanceFields',
		'instanceMethods',
		'classFields',
		'classMethods',
		'theName'
	],
	#category : 'SomLoader-Compiler'
}

{ #category : #adding }
SomClassGenerationContext >> addField: field [
	self isClassSide
		ifTrue:  [classFields add: field]
		ifFalse: [instanceFields add: field].
]

{ #category : #adding }
SomClassGenerationContext >> addFields: fieldNames [

	^ self isClassSide
		ifTrue: [self classFields: fieldNames]
		ifFalse: [self instanceFields: fieldNames]
]

{ #category : #adding }
SomClassGenerationContext >> addInstanceField: field [
	instanceFields add: field.
]

{ #category : #adding }
SomClassGenerationContext >> addMethod: methodSource [
	^ self isClassSide
		ifFalse: [self instanceMethods add: methodSource]
		ifTrue: [	self classMethods add: methodSource]
]

{ #category : #variables }
SomClassGenerationContext >> allClassFieldsIn: universe [

	| superClass |
	self superName = 'nil' ifTrue: [^ self classFields].
	superClass := universe
		globalAt: self superName asSymbol
		ifAbsent: ["self error: 'Field lookup: Cannot find my superclass ' , self superName , '!'"
			"Transcript
				cr;
				show: 'Field lookup: Cannot find my superclass ' , self superName , '!'."
			^ self classFields].
	^ superClass somClass allInstanceFields , self classFields.
]

{ #category : #variables }
SomClassGenerationContext >> allInstanceFieldsIn: universe [

	| superClass |
	self superName = 'nil' ifTrue: [^ self instanceFields].
	superClass := universe
		globalAt: self superName asSymbol
		ifAbsent: ["self error: 'Field lookup: Cannot find my superclass ' , self superName , '!'"
			"Transcript
				cr;
				show: 'Field lookup: Cannot find my superclass ' , self superName , '!'."
			^ self instanceFields].
	^ superClass allInstanceFields , self instanceFields.
]

{ #category : #assembling }
SomClassGenerationContext >> assembleIn: universe [

	^ self
		assembleIn: universe
		stub: (self createEmptyClassIn: universe).
]

{ #category : #assembling }
SomClassGenerationContext >> assembleIn: universe stub: classStub [

	self
		initInstanceSideOf: classStub in: universe;
		initClassSideOf: classStub in: universe;
		initFieldsOf: classStub in: universe.
	^ classStub
]

{ #category : #accessing }
SomClassGenerationContext >> classFields [
	^ classFields
]

{ #category : #accessing }
SomClassGenerationContext >> classFields: anObject [
	classFields := anObject
]

{ #category : #accessing }
SomClassGenerationContext >> classMethods [
	^ classMethods
]

{ #category : #accessing }
SomClassGenerationContext >> classMethods: anObject [
	classMethods := anObject
]

{ #category : #assembling }
SomClassGenerationContext >> createEmptyClassIn: universe [

	| superclass |
	superclass := universe
		globalAt: self superName
		ifAbsent: [universe loadSOMClass: self superName].
	^ universe classClass 
		inUniverse: universe
		withSomSuperClass: superclass.
]

{ #category : #initialization }
SomClassGenerationContext >> defaultSuperClassName [

	^ 'Object'
]

{ #category : #testing }
SomClassGenerationContext >> hasField: fieldName [

	^ self isClassSide
		ifTrue: [self classFields includes: fieldName]
		ifFalse: [self instanceFields includes: fieldName]
]

{ #category : #assembling }
SomClassGenerationContext >> initClassSideOf: somClass in: universe [

	| fields methods |
	self flag: #rkrk. "Duplication with #initInstanceSideOf:in:"
	somClass somClass somName: (universe newSymbol: self theName , ' class').
	fields := self classFields collect: [:each | universe newSymbol: each].
	somClass somClass somInstanceFields: (universe newArrayWithAll: fields).
	methods := self classMethods collect: [:each | each assembleIn: universe].
	somClass somClass somInstanceInvokables: (universe newArrayWithAll: methods).
]

{ #category : #assembling }
SomClassGenerationContext >> initFieldsOf: somClass in: universe [

	| nAdditionalFields nilObject |
	nAdditionalFields := somClass somClass somInstanceFields size.
	nilObject := universe globalNil.
	somClass fields: (Array new: nAdditionalFields).
	somClass numberOfFields - nAdditionalFields + 1
		to: somClass numberOfFields
		do: [:i | somClass fieldAtIndex: i put: nilObject].
]

{ #category : #assembling }
SomClassGenerationContext >> initInstanceSideOf: somClass in: universe [

	| fields methods |
	somClass somName: (universe newSymbol: self theName).
	fields := self instanceFields collect: [:each | universe newSymbol: each].
	somClass somInstanceFields: (universe newArrayWithAll: fields).
	methods := self instanceMethods collect: [:each | each assembleIn: universe].
	somClass somInstanceInvokables: (universe newArrayWithAll: methods).
]

{ #category : #initialization }
SomClassGenerationContext >> initialize [

	super initialize.
	self
		isClassSide: false;
		superName: self defaultSuperClassName;
		instanceFields: OrderedCollection new;
		classFields: OrderedCollection new;
		instanceMethods: OrderedCollection new;
		classMethods: OrderedCollection new;
		theName: ''.
]

{ #category : #accessing }
SomClassGenerationContext >> instanceFields [
	^ instanceFields
]

{ #category : #accessing }
SomClassGenerationContext >> instanceFields: anObject [
	instanceFields := anObject
]

{ #category : #accessing }
SomClassGenerationContext >> instanceMethods [
	^ instanceMethods
]

{ #category : #accessing }
SomClassGenerationContext >> instanceMethods: anObject [
	instanceMethods := anObject
]

{ #category : #accessing }
SomClassGenerationContext >> isClassSide [
	^ isClassSide
]

{ #category : #accessing }
SomClassGenerationContext >> isClassSide: anObject [
	isClassSide := anObject
]

{ #category : #accessing }
SomClassGenerationContext >> superName [
	^ superName
]

{ #category : #accessing }
SomClassGenerationContext >> superName: anObject [
	superName := anObject
]

{ #category : #accessing }
SomClassGenerationContext >> theName [
	^ theName
]

{ #category : #accessing }
SomClassGenerationContext >> theName: string [
	^ theName := string
]

{ #category : #accessing }
SomClassGenerationContext >> toggleClassSide [
	self isClassSide: self isClassSide not
]
