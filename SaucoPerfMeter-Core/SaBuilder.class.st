"
I help to build instances of SaReport from instances of AndreasSystemProfiler or MessageTally.
"
Class {
	#name : 'SaBuilder',
	#superclass : 'Object',
	#instVars : [
		'behaviorNodesMapping',
		'categoryNodesMapping',
		'methodNodesMapping',
		'rootTallyNodes',
		'totalTime',
		'report',
		'totalTally'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'building' }
SaBuilder >> build [
	report
		initializeNodes: rootTallyNodes
		totalTime: totalTime milliSeconds
		totalTally: totalTally
]

{ #category : 'initialization' }
SaBuilder >> initialize [
	super initialize.
	categoryNodesMapping := IdentityDictionary new.
	behaviorNodesMapping := IdentityDictionary new.
	methodNodesMapping := IdentityDictionary new.
	report := SaReport new
]

{ #category : 'registering nodes' }
SaBuilder >> registerAllCodeNodesFor: method [
	"Ensures that code nodes at all levels are registered."

	self registerCategoryNodeFor: method.
	self registerBehaviorNodeFor: method.
	self registerMethodNodeFor: method
]

{ #category : 'registering nodes' }
SaBuilder >> registerBehaviorNodeFor: method [
	| behavior |
	behavior := method origin.
	behaviorNodesMapping
		at: behavior
		ifAbsentPut: [ | categoryNode behaviorNode |
			categoryNode := categoryNodesMapping at: behavior category.
			behaviorNode := SaBehaviorNode new
				name: behavior name asString;
				categoryNode: categoryNode;
				report: report;
				yourself.
			categoryNode addBehavior: behaviorNode.
			behaviorNode ]
]

{ #category : 'registering nodes' }
SaBuilder >> registerCategoryNodeFor: method [
	| category |
	category := method origin category.
	categoryNodesMapping
		at: category
		ifAbsentPut: [ SaCategoryNode new
				name: category asString;
				report: report;
				yourself ]
]

{ #category : 'registering nodes' }
SaBuilder >> registerMethodNodeFor: method [
	methodNodesMapping
		at: method
		ifAbsentPut: [ | behaviorNode methodNode |
			behaviorNode := behaviorNodesMapping at: method origin.
			methodNode := SaMethodNode new
				name: method selector asString;
				behaviorNode: behaviorNode;
				report: report;
				yourself.
			behaviorNode methodNodes add: methodNode.
			methodNode ]
]

{ #category : 'accessing' }
SaBuilder >> report [
	^ report
]

{ #category : 'visiting' }
SaBuilder >> tallyNodeFor: aQSystemTally [
	"Answers a new tally node for the argument. Important: It also registers code nodes."

	| childrenTallyNodes methodNode tallyNode |
	"Depth-first"
	childrenTallyNodes := (aQSystemTally sonsOver: 0)
		collect: [ :each | self tallyNodeFor: each ].

	tallyNode := SaTallyNode new
		tally: aQSystemTally tally;
		children: childrenTallyNodes;
		report: report;
		yourself.

	"Handle root, which is an unreal tally with method = nil: 
	children are the only important in such case."
	aQSystemTally method ifNotNil: [
		"Ensure existence of category, behavior and method nodes."
		self registerAllCodeNodesFor: aQSystemTally method.
		methodNode := methodNodesMapping at: aQSystemTally method.
		methodNode addTallyNode: tallyNode ].

	^ tallyNode
]

{ #category : 'accessing' }
SaBuilder >> tallyRoot: tallyRoot [

	totalTally := tallyRoot tally.
	rootTallyNodes := { self tallyNodeFor: tallyRoot }.

	"For AndreasSystemProfiler, the received root is a nil>>nil so we just keep its children."
	(rootTallyNodes size = 1 and: [ rootTallyNodes anyOne methodNode isNil ])
		ifTrue: [
			| nodeToDiscard |
			nodeToDiscard := rootTallyNodes anyOne.
			rootTallyNodes := nodeToDiscard children.
			nodeToDiscard children: #() ]
]

{ #category : 'accessing' }
SaBuilder >> totalTime: aNumber [
	totalTime := aNumber
]
