"
My subclasses represent color mappings from instances of `SaCodeNode`.
"
Class {
	#name : 'SaColorMap',
	#superclass : 'Object',
	#instVars : [
		'theme'
	],
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
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
