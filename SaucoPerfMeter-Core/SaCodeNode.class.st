"
I represent a piece of code in the SaReport.
"
Class {
	#name : 'SaCodeNode',
	#superclass : 'Object',
	#instVars : [
		'name',
		'report',
		'cachedNetTally',
		'cachedTally'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'accessing' }
SaCodeNode >> calculatedNetTally [

	^ self children inject: 0 into: [ :sum :each | sum + each netTally ]
]

{ #category : 'accessing' }
SaCodeNode >> children [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
SaCodeNode >> codeColor [

	^ report colorMap colorAt: self
]

{ #category : 'accessing' }
SaCodeNode >> fullName [
	^ self subclassResponsibility
]

{ #category : 'testing' }
SaCodeNode >> hasChildren [

	^ self children notEmpty
]

{ #category : 'testing' }
SaCodeNode >> isRelevant [

	^ self netTallyRatio >= report minimumRelevantRatio
]

{ #category : 'accessing' }
SaCodeNode >> name [
	^ name
]

{ #category : 'accessing' }
SaCodeNode >> name: aString [

	name := aString
]

{ #category : 'accessing' }
SaCodeNode >> netTally [
	^ cachedNetTally ifNil: [ cachedNetTally := self calculatedNetTally ]
]

{ #category : 'accessing' }
SaCodeNode >> netTallyRatio [
	"Answer the ratio of my #netTally respect to report's #totalTally."

	^ self netTally asFloat / report totalTally
]

{ #category : 'accessing' }
SaCodeNode >> netTime [

	^ self report totalTime * self netTallyRatio
]

{ #category : 'printing' }
SaCodeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $(;
		nextPutAll: self fullName;
		nextPut: $)
]

{ #category : 'accessing' }
SaCodeNode >> report [
	^ report
]

{ #category : 'accessing' }
SaCodeNode >> report: anObject [
	report := anObject
]
