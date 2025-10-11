"
A SaTallyNodeTest is a test class for testing the behavior of SaTallyNode
"
Class {
	#name : 'SaTallyNodeTest',
	#superclass : 'SaTest',
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'testing' }
SaTallyNodeTest >> testWithAllChildren [

	self assert: nodeB withAllChildren equals: { 
			nodeBAAA.
			nodeBAA.
			nodeBA.
			nodeB } reversed.
	self assert: nodeBAAA withAllChildren equals: { nodeBAAA }
]

{ #category : 'testing' }
SaTallyNodeTest >> testWithAllParents [

	self assert: root withAllParents equals: { root }.
	self assert: nodeB withAllParents equals: { nodeB. root }.
	self assert: nodeBAAA withAllParents equals: { nodeBAAA. nodeBAA. nodeBA. nodeB. root }
]
