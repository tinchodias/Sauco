"
I represent a tree node in the SaReport.

My collaborators are:

	- methodNode: Represents the method that was observed by the profiler, belonging to a context stack. N:1 relation.
	- tally: The number of times this method was observed as part of a context stack.
	- parent: Either nil for root nodes, or another node when I'm a children. See #children:. N:1 relation.
	- children: A collection of other tally nodes. Obviously, I'm a leaf node when it's empty. 1:N relation.
	

"
Class {
	#name : 'SaTallyNode',
	#superclass : 'Object',
	#instVars : [
		'methodNode',
		'tally',
		'children',
		'report',
		'parent'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'instance creation' }
SaTallyNode class >> report: aSaReport methodNode: aSaMethodNode tally: anInteger children: aSaTallyNode [
	^ self new
		report: aSaReport;
		methodNode: aSaMethodNode;
		tally: anInteger;
		children: aSaTallyNode;
		yourself
]

{ #category : 'accessing' }
SaTallyNode >> allBehaviorNodes [
	^ self allMethodNodes collect: [ :each | each behaviorNode ] as: Set
]

{ #category : 'accessing' }
SaTallyNode >> allCategoryNodes [
	^ self allBehaviorNodes collect: [ :each | each categoryNode ] as: Set
]

{ #category : 'accessing' }
SaTallyNode >> allLeaves [
	^ children ifEmpty: [ {self} ] ifNotEmpty: [ children flatCollect: #allLeaves ]
]

{ #category : 'accessing' }
SaTallyNode >> allMethodNodes [
	^ self withAllChildren collect: [ :each | each methodNode ] as: Set
]

{ #category : 'accessing' }
SaTallyNode >> categoryName [

	^ methodNode categoryName
]

{ #category : 'accessing' }
SaTallyNode >> children [
	^ children
]

{ #category : 'accessing' }
SaTallyNode >> children: aCollectionOfTallyNodes [
	"Set the children nodes. We let parents the responsability of keeping the bi-directional relationshipup-to-date (see #parent:)."

	children ifNotNil: [
		children do: [ :each |
			each parent: nil ] ].

	children := aCollectionOfTallyNodes.

	aCollectionOfTallyNodes do: [ :each |
		each parent: self ].
]

{ #category : 'accessing' }
SaTallyNode >> fullName [

	^ self methodNode fullName
]

{ #category : 'testing' }
SaTallyNode >> hasChildren [

	^ self children notEmpty
]

{ #category : 'testing' }
SaTallyNode >> hasParent [

	^ parent isNotNil
]

{ #category : 'testing' }
SaTallyNode >> isRelevant [

	^ self ratio >= report minimumRelevantRatio
]

{ #category : 'accessing' }
SaTallyNode >> methodNode [
	^ methodNode
]

{ #category : 'accessing' }
SaTallyNode >> methodNode: aSaMethodNode [

	methodNode := aSaMethodNode
]

{ #category : 'accessing' }
SaTallyNode >> netPercentage [
	^ 100.0 * self netRatio
]

{ #category : 'accessing' }
SaTallyNode >> netRatio [
	^ self netTally asFloat / self report totalTally
]

{ #category : 'accessing' }
SaTallyNode >> netTally [
	^ tally - (children sum: #tally)
]

{ #category : 'accessing' }
SaTallyNode >> netTime [
	"Answer the net time (respect to children time)."

	^ self report totalTime * self netRatio
]

{ #category : 'accessing' }
SaTallyNode >> parent [

	^ parent
]

{ #category : 'accessing' }
SaTallyNode >> parent: anotherTallyNodeOrNil [
	"Set the parent. We let parents the responsability of keeping the bi-directional relationship up-to-date (see #children:)."
	
	parent := anotherTallyNodeOrNil
]

{ #category : 'accessing' }
SaTallyNode >> parentRatio [
	^ tally asFloat / self parent tally
]

{ #category : 'printing' }
SaTallyNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	report durationPrinter print: self time on: aStream.
	aStream
		nextPutAll: ' - ';
		nextPutAll: methodNode fullName;
		nextPut: $)
]

{ #category : 'accessing' }
SaTallyNode >> ratio [
	^ tally asFloat / self report totalTally
]

{ #category : 'accessing' }
SaTallyNode >> report [
	^ report
]

{ #category : 'accessing' }
SaTallyNode >> report: aSaReport [
	report := aSaReport
]

{ #category : 'accessing' }
SaTallyNode >> tally [
	^ tally
]

{ #category : 'accessing' }
SaTallyNode >> tally: anInteger [
	tally := anInteger
]

{ #category : 'accessing' }
SaTallyNode >> time [
	^ report totalTime * self ratio
]

{ #category : 'accessing' }
SaTallyNode >> withAllChildren [
	^ {self}, (children flatCollect: #withAllChildren)
]

{ #category : 'accessing' }
SaTallyNode >> withAllParents [

	^ parent
		  ifNil: [ { self } ]
		  ifNotNil: [ { self } , parent withAllParents ]
]
