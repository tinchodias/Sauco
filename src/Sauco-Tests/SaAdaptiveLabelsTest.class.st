Class {
	#name : 'SaAdaptiveLabelsTest',
	#superclass : 'TestCase',
	#instVars : [
		'report',
		'categoryH',
		'behaviorP',
		'methodX',
		'root',
		'canvas'
	],
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'running' }
SaAdaptiveLabelsTest >> setUp [
	super setUp.

	report := SaReport new.
	categoryH := SaCategoryNode new
					report: report;
					name: 'H';
					yourself.
	behaviorP := SaBehaviorNode new
					report: report;
					name: 'P';
					categoryNode: categoryH;
					yourself.
	methodX := SaMethodNode new
					report: report;
					name: (String new: 200 withAll: $x);
					behaviorNode: behaviorP;
					yourself.
	root := SaTallyNode
		report: report
		methodNode: methodX
		tally: 1000
		children: #().
	report
		initializeNodes: {root}
		totalTime: 1000 milliSeconds
		totalTally: 1000.
	report
		colorMap:
			(SaCategoryPrefixColorMap new
				mapPrefixes: { categoryH name }
					from: Color lightBlue;
				yourself)	.
	canvas := report asRSCanvas
]

{ #category : 'tests' }
SaAdaptiveLabelsTest >> testBigEnoughToShowLabels [

	canvas camera scale: 1.0.
	canvas signalUpdate.
	self assert: (canvas shapes anySatisfy: #isLabel)
]

{ #category : 'tests' }
SaAdaptiveLabelsTest >> testTooSmallToShowLabels [

	canvas camera scale: 0.25.
	canvas signalUpdate.
	self deny: (canvas shapes anySatisfy: #isLabel)
]
