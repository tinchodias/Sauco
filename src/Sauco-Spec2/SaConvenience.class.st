"
I just hold some utility methods (sorry!)
"
Class {
	#name : 'SaConvenience',
	#superclass : 'Object',
	#category : 'Sauco-Spec2',
	#package : 'Sauco-Spec2'
}

{ #category : 'ui' }
SaConvenience class >> codeIcon: aSaCodeNode [

	^ (FormCanvas extent: 16 @ 16)
		fillRectangle: (3 @ 3 extent: 11 @ 11)
			color: aSaCodeNode codeColor
"			borderWidth: 0
			borderColor: Color transparent";
		form
]

{ #category : 'ui' }
SaConvenience class >> codeNameMorphFor: aSaCodeNode [
	^ EpMorphFactory default rowWithAll: {
			(self codeIcon: aSaCodeNode) asMorph.
			aSaCodeNode fullName asMorph.
			"(aSaCodeNode isRelevant
				ifTrue: [ aSaCodeNode fullName asMorph ]
				ifFalse: [ self shadowedTextFor: aSaCodeNode fullName ])" }
]

{ #category : 'ui' }
SaConvenience class >> inspectionCodeList: aBuilder items: itemsCollection [

	^ aBuilder newTable
		items: itemsCollection asArray; "It doesn't work with Set, for example."
		sortingBlock: [ :a :b | a netTally > b netTally ];
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | self ratioIcon: each netTallyRatio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | self codeIcon: each ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | each fullName ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ' ' join: each nameTags ])
]

{ #category : 'printing' }
SaConvenience class >> multipleLineDescriptionFor: node [ 

	^ '{1}
Method: 		{2}
Category: 	{3}' format: {
		node relevanceDescription.
		node fullName.
		node categoryName.
		}
]

{ #category : 'printing' }
SaConvenience class >> printRatio: aNumber [

	^ (((100.0 * aNumber) roundTo: 0.01) printShowingDecimalPlaces: 2), '%'
]

{ #category : 'ratio' }
SaConvenience class >> ratioBottomColor [

	^ Smalltalk ui theme baseColor
]

{ #category : 'ratio' }
SaConvenience class >> ratioIcon: ratio [

	| width height |
	width := 14.
	height := 12.

	^ (FormCanvas extent: width @ height)
		fillColor: self ratioBottomColor;
		drawRectangle: (0 asPoint extent: (ratio * (width-1)) @ (height-1))
			color: self ratioTopColor
			borderWidth: 1
			borderColor: self ratioBottomColor;
		form

]

{ #category : 'ratio' }
SaConvenience class >> ratioTopColor [

	^ 	Smalltalk ui theme textColor
]

{ #category : 'ui' }
SaConvenience class >> shadowedTextFor: aString [
	^ EpMorphFactory default stringFor: aString color: EpMorphFactory default softerTextColor
]

{ #category : 'ui' }
SaConvenience class >> tallyNodeMorphFor: aSaTallyNode [

	| contents |
	contents := {
		aSaTallyNode relevanceDescription asMorph.
		(self codeNameMorphFor: aSaTallyNode methodNode) }.

	^ EpMorphFactory default rowWithAll: contents
]
