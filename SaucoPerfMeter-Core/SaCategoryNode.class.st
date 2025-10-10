"
I represent a category in the SaReport.
"
Class {
	#name : 'SaCategoryNode',
	#superclass : 'SaCodeNode',
	#instVars : [
		'behaviorNodes'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'accessing' }
SaCategoryNode >> addBehavior: aBehaviorNode [
	behaviorNodes add: aBehaviorNode
]

{ #category : 'accessing' }
SaCategoryNode >> behaviorNodes [
	^ behaviorNodes
]

{ #category : 'accessing' }
SaCategoryNode >> behaviorNodes: anObject [
	behaviorNodes := anObject
]

{ #category : 'accessing' }
SaCategoryNode >> categoryName [
	
	^ name
]

{ #category : 'accessing' }
SaCategoryNode >> children [
	^ behaviorNodes
]

{ #category : 'accessing' }
SaCategoryNode >> fullName [
	^ name
]

{ #category : 'initialization' }
SaCategoryNode >> initialize [
	super initialize.
	behaviorNodes := OrderedCollection new
]
