Class {
	#name : 'SaTest',
	#superclass : 'TestCase',
	#instVars : [
		'methodZ',
		'methodY',
		'methodX',
		'categoryI',
		'categoryH',
		'behaviorQ',
		'behaviorP',
		'report',
		'root',
		'nodeAA',
		'nodeA',
		'nodeBAAA',
		'nodeBAA',
		'nodeBA',
		'nodeB'
	],
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'testing' }
SaTest class >> isAbstract [

	^ self = SaTest
]

{ #category : 'running' }
SaTest >> behaviorP [
	^ behaviorP ifNil: [
		behaviorP := SaBehaviorNode new
				report: report;
				name: 'P';
				categoryNode: self categoryH;
				yourself ]
]

{ #category : 'running' }
SaTest >> behaviorQ [
	^ behaviorQ ifNil: [
		behaviorQ := SaBehaviorNode new
				report: report;
				name: 'Q';
				categoryNode: self categoryI;
				yourself ]
]

{ #category : 'running' }
SaTest >> categoryH [
	^ categoryH ifNil: [
		categoryH := SaCategoryNode new
				report: report;
				name: 'H';
				yourself ]
]

{ #category : 'running' }
SaTest >> categoryI [
	^ categoryI ifNil: [
		categoryI := SaCategoryNode new
				report: report;
				name: 'I';
				yourself ]
]

{ #category : 'running' }
SaTest >> methodX [
	^ methodX ifNil: [
		methodX := SaMethodNode new
				report: report;
				name: 'x';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : 'running' }
SaTest >> methodY [
	^ methodY ifNil: [
		methodY := SaMethodNode new
				report: report;
				name: 'y';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : 'running' }
SaTest >> methodZ [
	^ methodZ ifNil: [
		methodZ := SaMethodNode new
				report: report;
				name: 'z';
				behaviorNode: self behaviorQ;
				yourself ]
]

{ #category : 'running' }
SaTest >> setUp [

	super setUp.
	report := SaReport new.
	root := SaTallyNode
		report: report
		methodNode: self methodX
		tally: 1000
		children: { 
			nodeA := (SaTallyNode
				report: report
				methodNode: self methodY
				tally: 600
				children: {
					nodeAA := (SaTallyNode
						report: report
						methodNode: self methodY
						tally: 600
						children: #())}).
			nodeB := (SaTallyNode
				report: report
				methodNode: self methodZ
				tally: 400
				children: {
					nodeBA := (SaTallyNode
						report: report
						methodNode: self methodZ
						tally: 300
						children: {
							nodeBAA := (SaTallyNode
								report: report
								methodNode: self methodZ
								tally: 200
								children: {
									nodeBAAA := (SaTallyNode
										report: report
										methodNode: self methodZ
										tally: 100
										children: #())})})})}.
	report
		initializeNodes: {root}
		totalTime: 2000 milliSeconds
		totalTally: 1000
]
