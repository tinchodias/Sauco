"
I am initialized for a register and generate colors for each of its code nodes.
"
Class {
	#name : 'SaCodeColorMap',
	#superclass : 'SaColorMap',
	#instVars : [
		'colorByCodeMap'
	],
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'instance creation' }
SaCodeColorMap class >> forReport: aSaReport [

	^ self basicNew
		  initializeForReport: aSaReport;
		  yourself
]

{ #category : 'accessing' }
SaCodeColorMap >> colorAt: aSaCodeNode [

	^ colorByCodeMap at: aSaCodeNode
]

{ #category : 'private' }
SaCodeColorMap >> deepRegister: aCodeCollection colors: colors [

	aCodeCollection ifEmpty: [ ^ self ].

	colors withIndexDo: [ :color :index | 
		| code |
		code := aCodeCollection at: index.
		colorByCodeMap at: code put: color.
		self
			deepRegister: code children
			colors: (self
				gradient: code children size
				from: color
				to: (color alpha: 0.5)) ]
]

{ #category : 'private' }
SaCodeColorMap >> gradient: count from: base to: next [

	^ (1 to: count) collect: [ :each | (base mixed: each / count with: next) alpha: 0.75 ]
]

{ #category : 'initialization' }
SaCodeColorMap >> initialize [

	super initialize.
	colorByCodeMap := Dictionary new
]

{ #category : 'initialization' }
SaCodeColorMap >> initializeForReport: aReport [

	| colors categories relevantCount irrelevantCount |
	self initialize.

	categories := aReport allCategoryNodes.
	relevantCount := categories count: [ :each | each isRelevant ].
	irrelevantCount := categories size - relevantCount.
	colors :=
		((Color wheel: relevantCount) collect: [ :each | each mixed: 0.5 with: theme backgroundColor ]),
		(Array new: irrelevantCount withAll: theme backgroundColor).

	self deepRegister: categories colors: colors
]
