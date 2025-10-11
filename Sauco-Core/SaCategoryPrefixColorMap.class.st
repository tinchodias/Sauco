Class {
	#name : 'SaCategoryPrefixColorMap',
	#superclass : 'SaColorMap',
	#instVars : [
		'colorAssociations',
		'defaultColor'
	],
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'accessing' }
SaCategoryPrefixColorMap >> colorAssociations [

	^ colorAssociations
]

{ #category : 'accessing' }
SaCategoryPrefixColorMap >> colorAt: aSaCodeNode [

	^ self colorForCategory: aSaCodeNode categoryName 
]

{ #category : 'accessing' }
SaCategoryPrefixColorMap >> colorForCategory: aString [ 

	^ (self colorAssociations
		detect: [ :each | aString beginsWith: each key ]
		ifNone: [ defaultColor ]) value

]

{ #category : 'initialization' }
SaCategoryPrefixColorMap >> initialize [

	super initialize.

	colorAssociations := #().
	defaultColor := theme baseColor translucent.

]

{ #category : 'accessing' }
SaCategoryPrefixColorMap >> labelColorAt: aSaCodeNode [

	^ (self colorAt: aSaCodeNode) luminance < 0.5
		  ifTrue: [ Color white ]
		  ifFalse: [ Color black ]
]

{ #category : 'initialization' }
SaCategoryPrefixColorMap >> mapPrefixes: aCollectionOfStrings from: aColor [

	| anotherColor minHueIncrement |
	minHueIncrement := 5.
	anotherColor := Color
		h: aColor hue + (minHueIncrement * aCollectionOfStrings size)
		s: aColor saturation * 0.7
		v: aColor brightness * 1.3.
	
	self mapPrefixes: aCollectionOfStrings from: aColor to: anotherColor
]

{ #category : 'initialization' }
SaCategoryPrefixColorMap >> mapPrefixes: aCollectionOfStrings from: aColor to: anotherColor [

	| colorRamp |
	colorRamp := aColor 
		mix: anotherColor
		shades: aCollectionOfStrings size.

	colorAssociations := colorAssociations, 
		(aCollectionOfStrings
			collectWithIndex: [ :each :index |
				each -> (colorRamp at: index) ]).

]
