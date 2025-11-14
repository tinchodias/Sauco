"
I represent a report of a profiling execution.
"
Class {
	#name : 'SaReport',
	#superclass : 'Object',
	#instVars : [
		'totalTime',
		'totalTally',
		'rootTallyNodes',
		'durationPrinter',
		'colorMap'
	],
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'examples' }
SaReport class >> exampleAll: aBlock [

	| exampleSelector |
	exampleSelector := thisContext sender selector storeString.
	
	self
		openInspectorOn: (self newWithASPOn: aBlock)
		label: exampleSelector, ' - AndreasSystemProfiler'.

	self
		openInspectorOn: (self newWithMTOn: aBlock)
		label: exampleSelector, ' - MessageTally'
]

{ #category : 'examples' }
SaReport class >> exampleBenchFib [
	self exampleAll: [ 32 benchFib ]
]

{ #category : 'examples' }
SaReport class >> exampleDiskWrite [
	| baseName |
	baseName := 'exampleDiskWrite'.
	self
		exampleAll: [ (baseName , Time primUTCMicrosecondsClock asString) asFileReference
				writeStreamDo: [ :stream | 1 to: 200000 do: [ :each | each printOn: stream ] ] ].
	('.' asFileReference childrenMatching: baseName , '*') do: [ :each | each ensureDelete ]
]

{ #category : 'examples' }
SaReport class >> exampleFactorial [
	self exampleAll: [ 1000 timesRepeat: [ 1000 factorial ] ]
]

{ #category : 'examples' }
SaReport class >> exampleFuelAllIcons [
	self exampleAll: [ | array |
		array := FLSerializer serializeToByteArray: Smalltalk ui icons. 
		FLMaterializer materializeFromByteArray: array ]
]

{ #category : 'examples' }
SaReport class >> exampleRandomNext [
	self
		exampleAll: [ | random |
			random := Random seed: 1.
			(1 to: 500000) collect: [ :each | random next ] ]
]

{ #category : 'examples' }
SaReport class >> exampleReadFuelFiles [
	"Inspect instances of SaReport stored in fuel files"

	('.' asFileReference childrenMatching: 'profile_report.*.fuel') do: [ :each | 
		self
			openInspectorOn: (FLMaterializer materializeFromFileNamed: each pathString)
			label: each basename ]
]

{ #category : 'examples' }
SaReport class >> exampleUUID [
	self exampleAll: [ (1 to: 100000) collect: [ :each | UUID new ] ]
]

{ #category : 'examples' }
SaReport class >> exampleWait [
	self exampleAll: [ 3 seconds wait ]
]

{ #category : 'examples' }
SaReport class >> exampleWorldFor5Seconds [
	
	(self newWithASPFor: 5 seconds) inspect
]

{ #category : 'examples' }
SaReport class >> exampleZincGet [

	self exampleAll: [ ZnEasy get: 'http://pharo.org/' ]
]

{ #category : 'convenience' }
SaReport class >> newWithASPFor: aDuration [
	"Profile the system during aDuration."

	^ self newWithASPOn: [ aDuration wait ]
]

{ #category : 'convenience' }
SaReport class >> newWithASPOn: aBlock [
	| profiler semaphore saucoReport |
	semaphore := Semaphore new.
	profiler := AndreasSystemProfiler new.
	[ "We fork just to cut stack trace: the ASP report will start at this method context"
	profiler startProfiling.
	aBlock value.
	profiler stopProfiling.
	saucoReport := profiler saucoAsReport.
	semaphore signal ] fork.
	semaphore wait.
"	profiler doReport."
	^ saucoReport
]

{ #category : 'convenience' }
SaReport class >> newWithMTFor: aDuration [
	"Profile the system during aDuration."

	^ self newWithMTOn: [ aDuration wait ]
]

{ #category : 'convenience' }
SaReport class >> newWithMTOn: aBlock [
	| profiler |
	profiler := MessageTally new.
	profiler reportOtherProcesses: false.
	[ profiler spyEvery: 1 on: aBlock.
	^ profiler saucoAsReport ]
		ensure: [ "Send of #close must be done at the end because it nilizes the instance variables" profiler close ]
]

{ #category : 'private' }
SaReport class >> openInspectorOn: anObject label: aString [
	"This works on Pharo 13 and 14"

	(Smalltalk tools toolNamed: #inspector)
		inspect: anObject
		label: aString
]

{ #category : 'accessing' }
SaReport >> allBehaviorNodes [
	^ rootTallyNodes flatCollect: #allBehaviorNodes
]

{ #category : 'accessing' }
SaReport >> allCategoryNodes [
	^ (rootTallyNodes flatCollect: #allCategoryNodes) sorted: [:a :b | a netTallyRatio > b netTallyRatio ]
]

{ #category : 'accessing' }
SaReport >> allMethodNodes [
	^ rootTallyNodes flatCollect: #allMethodNodes
]

{ #category : 'accessing' }
SaReport >> allTallyNodes [
	^ rootTallyNodes flatCollect: #withAllChildren
]

{ #category : 'converting' }
SaReport >> asFuelByteArray [
	^ FLSerializer serializeToByteArray: self
]

{ #category : 'accessing' }
SaReport >> colorMap [

	^ colorMap ifNil: [ colorMap := SaCodeColorMap forReport: self ]
]

{ #category : 'accessing' }
SaReport >> colorMap: aSaColorMap [

	colorMap := aSaColorMap
]

{ #category : 'accessing' }
SaReport >> durationPrinter [

	^ durationPrinter ifNil: [ 
		  durationPrinter := SaAdaptedDurationPrinter new ]
]

{ #category : 'accessing' }
SaReport >> durationPrinter: anObject [

	durationPrinter := anObject
]

{ #category : 'initialization' }
SaReport >> initializeNodes: aCollection totalTime: aDuration totalTally: anInteger [ 
	rootTallyNodes := aCollection.
	totalTime := aDuration.
	totalTally := anInteger
]

{ #category : 'accessing' }
SaReport >> methodNodeLeaves [

	^ (self tallyLeaves collect: #methodNode) asSet 
			sorted: [ :a :b | a netTally > b netTally ]
]

{ #category : 'testing' }
SaReport >> minimumRelevantRatio [
	"Answer the minimum ratio for either a tally or a code node to be considered relevant."

	^ 0.03
]

{ #category : 'printing' }
SaReport >> printOn: aStream [

	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	self durationPrinter print: self totalTime on: aStream.
	aStream nextPut: $)
]

{ #category : 'accessing' }
SaReport >> rootTallyNodes [
	^ rootTallyNodes
]

{ #category : 'accessing' }
SaReport >> tallyLeaves [
	^ rootTallyNodes flatCollect: #allLeaves
]

{ #category : 'accessing' }
SaReport >> totalTally [
	^ totalTally
]

{ #category : 'accessing' }
SaReport >> totalTime [
	^ totalTime
]
