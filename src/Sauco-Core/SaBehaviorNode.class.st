"
I represent a class or trait (instance or class side) in the SaReport.
"
Class {
	#name : 'SaBehaviorNode',
	#superclass : 'SaCodeNode',
	#instVars : [
		'categoryNode',
		'methodNodes'
	],
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'accessing' }
SaBehaviorNode >> addMethod: aMethodNode [
	methodNodes add: aMethodNode
]

{ #category : 'accessing' }
SaBehaviorNode >> categoryName [
	^ categoryNode name
]

{ #category : 'accessing' }
SaBehaviorNode >> categoryNode [
	^ categoryNode
]

{ #category : 'accessing' }
SaBehaviorNode >> categoryNode: anObject [
	categoryNode := anObject
]

{ #category : 'accessing' }
SaBehaviorNode >> children [
	^ methodNodes
]

{ #category : 'accessing' }
SaBehaviorNode >> fullName [
	^ name
]

{ #category : 'initialization' }
SaBehaviorNode >> initialize [
	super initialize.
	methodNodes := OrderedCollection new
]

{ #category : 'accessing' }
SaBehaviorNode >> methodNodes [
	^ methodNodes
]

{ #category : 'accessing' }
SaBehaviorNode >> methodNodes: anObject [
	methodNodes := anObject
]
