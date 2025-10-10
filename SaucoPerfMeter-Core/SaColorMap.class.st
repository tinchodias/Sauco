Class {
	#name : 'SaColorMap',
	#superclass : 'Object',
	#instVars : [
		'theme'
	],
	#category : 'SaucoPerfMeter-Core',
	#package : 'SaucoPerfMeter-Core'
}

{ #category : 'accessing' }
SaColorMap >> colorAt: aSaCodeNode [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
SaColorMap >> initialize [

	super initialize.
	theme := Smalltalk ui theme.
]

{ #category : 'accessing' }
SaColorMap >> labelColorAt: aSaCodeNode [

	^ self theme textColor
]

{ #category : 'accessing' }
SaColorMap >> theme [

	^ theme
]

{ #category : 'accessing' }
SaColorMap >> theme: aUITheme [

	theme := aUITheme
]
