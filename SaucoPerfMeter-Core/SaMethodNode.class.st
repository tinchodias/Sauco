"
I represent a method in the SaReport.
"
Class {
	#name : 'SaMethodNode',
	#superclass : 'SaCodeNode',
	#instVars : [
		'behaviorNode',
		'tallyNodes'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'accessing' }
SaMethodNode >> addTallyNode: aSaTallyNode [ 
	"Register aSaTallyNode and establish the bi-directional knowledge as well."

	tallyNodes add: aSaTallyNode.
	aSaTallyNode methodNode: self
]

{ #category : 'accessing' }
SaMethodNode >> behaviorName [
	^ behaviorNode name
]

{ #category : 'accessing' }
SaMethodNode >> behaviorNode [
	^ behaviorNode
]

{ #category : 'accessing' }
SaMethodNode >> behaviorNode: anObject [
	behaviorNode := anObject
]

{ #category : 'accessing' }
SaMethodNode >> calculatedNetTally [

	^ tallyNodes inject: 0 into: [ :sum :each | sum + each netTally ]
]

{ #category : 'accessing' }
SaMethodNode >> categoryName [
	^ behaviorNode categoryName
]

{ #category : 'accessing' }
SaMethodNode >> children [
	^ #()
]

{ #category : 'accessing' }
SaMethodNode >> compiledMethodInCurrentImageIfPresent: presentBlock ifAbsent: absentBlock [
	(self class environment classOrTraitNamed: self behaviorName)
		ifNotNil: [ :behavior | 
			behavior 
				compiledMethodAt: name asSymbol 
				ifPresent: [ :method | ^ presentBlock value: method ] 
				ifAbsent: [  ] ].
	^ absentBlock value
]

{ #category : 'accessing' }
SaMethodNode >> fullName [
	^ self behaviorName, '>>', name
]

{ #category : 'initialization' }
SaMethodNode >> initialize [
	super initialize.
	tallyNodes := OrderedCollection new
]

{ #category : 'accessing' }
SaMethodNode >> tallyNodes [
	^ tallyNodes
]

{ #category : 'accessing' }
SaMethodNode >> tallyNodes: anObject [
	tallyNodes := anObject
]
