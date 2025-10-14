Class {
	#name : 'SaFlameGraph',
	#superclass : 'SaGraphBuilder',
	#instVars : [
		'tallyNodeSelectBlock',
		'tallyNodes',
		'flameBoxes',
		'flameLabels',
		'flameBoxPadding',
		'ellipsis',
		'flameLabelKey',
		'logicalFontSize',
		'shrinkPace',
		'minimalScaleToShowText',
		'popupInteraction'
	],
	#category : 'Sauco-Roassal',
	#package : 'Sauco-Roassal'
}

{ #category : 'building' }
SaFlameGraph >> build [

	self prepareToBuild.
	
	builder
		from: (self selectTallyNodesFrom: tallyNodes)
			using: [ :eachNode |
				self selectTallyNodesFrom: eachNode children ];
		build.

	builder canvas
		color: self theme backgroundColor;
		when: RSScaleChangedEvent
			send: #onCanvasScaled:
			to: self.

	"Additional setup for the box shapes (the flame boxes)"
	flameBoxes := builder shapes.
	flameBoxes do: [ :eachFlameBox |
		eachFlameBox
			color: eachFlameBox model methodNode codeColor;
			addInteraction: RSKeepBorderWidthRatioInteraction ].

	self prepareLabels
]

{ #category : 'accessing' }
SaFlameGraph >> considerAllNodes [

	tallyNodeSelectBlock := [ :_ | true ]
]

{ #category : 'accessing' }
SaFlameGraph >> considerOnlyRelevantNodes [

	tallyNodeSelectBlock := #isRelevant
]

{ #category : 'initialization' }
SaFlameGraph >> initialize [

	super initialize.
	
	ellipsis := '...'.
	shrinkPace := 2.

	flameLabelKey := #FlameLabel.

	flameBoxPadding := 4 @ 4.

	minimalScaleToShowText := 0.4.
	logicalFontSize := StandardFonts defaultFont pointSize.

	self considerOnlyRelevantNodes
]

{ #category : 'private' }
SaFlameGraph >> onCanvasScaled: anEvent [

	self updateLabels.

	anEvent signalUpdate
]

{ #category : 'building' }
SaFlameGraph >> prepareLabels [

	"Prepare the labels, that will be added depending on the camera scale"
	| highlightInteractionForLabels |
	highlightInteractionForLabels := self highlightInteraction.
	highlightInteractionForLabels highlightShapes: [ :label |
		{ label propertyAt: flameLabelKey } ].
	flameBoxes do: [ :eachFlameBox |
		| label |
		label := RSLabel new
			model: eachFlameBox model;
			position: eachFlameBox position;
			addInteraction: popupInteraction;
			addInteraction: highlightInteractionForLabels;
			yourself.
		eachFlameBox propertyAt: flameLabelKey put: label.
		label propertyAt: flameLabelKey put: eachFlameBox ]
]

{ #category : 'private' }
SaFlameGraph >> prepareToBuild [

	builder := RSFlameGraph new.
	builder
		modelWeight: [ :tallyNode | tallyNode tally ];
		graphWidth: 1000;
		boxHeight: logicalFontSize + (flameBoxPadding y * 2);
		"Workaround: when gap's x is non-zero, the children narrow on each level."
		gap: 0 @ 0.

	"Share instance of the interaction"
	popupInteraction := self popupInteraction.

	builder boxShape
		cornerRadius: 0;
		border:
			(RSBorder new
			  width: 0.5;
			  color: self theme textColor;
			  yourself);
		addInteraction: popupInteraction;
		addInteraction: self highlightInteraction;
		when: RSMouseDoubleClick
			do: [ :each | each shape model inspect ]
			for: builder
]

{ #category : 'private' }
SaFlameGraph >> selectTallyNodesFrom: someNodes [
	"Answer a filtered and sorted list of SPMTallyNodes.
	They are sorted by #fullName to help comparing visually one profile run with another."

	^ (someNodes select: self tallyNodeSelectBlock) 
		sorted: [ :a :b | a methodNode fullName < b methodNode fullName ]

]

{ #category : 'private' }
SaFlameGraph >> setText: aString widthLimit: aNumber onLabel: label [
		
	| shrinkedString |
	"The complete original string may already fit"
	label text: aString.

	"Shrink the string until it fits"
	shrinkedString := aString.
	[ label width > aNumber and: [ shrinkedString size > shrinkPace ] ]
		whileTrue: [
			shrinkedString := shrinkedString allButLast: shrinkPace.
			label text: shrinkedString, ellipsis ]
]

{ #category : 'accessing' }
SaFlameGraph >> tallyNodeSelectBlock [

	^ tallyNodeSelectBlock
]

{ #category : 'accessing' }
SaFlameGraph >> tallyNodeSelectBlock: aUnaryBlockClosure [

	tallyNodeSelectBlock := aUnaryBlockClosure
]

{ #category : 'accessing' }
SaFlameGraph >> tallyNodes [

	^ tallyNodes
]

{ #category : 'accessing' }
SaFlameGraph >> tallyNodes: aCollectionOfSaTallyNodes [

	tallyNodes := aCollectionOfSaTallyNodes
]

{ #category : 'private' }
SaFlameGraph >> updateLabelOf: aFlameBox scaledFontSize: scaledFontSize [

	| label maxLabelWidth |
	label := aFlameBox propertyAt: flameLabelKey.
	label
		color: (report colorMap labelColorAt: aFlameBox model);
		fontSize: scaledFontSize.
	
	maxLabelWidth := aFlameBox width - (flameBoxPadding x * 2).
	self
		setText: aFlameBox model methodNode fullName
		widthLimit: maxLabelWidth
		onLabel: label.

	"position: aFlameBox position --> to center"
	RSLocation new
		inner; middle; left;
		offset: flameBoxPadding x @ 0;
		stick: label on: aFlameBox.

	"Ensure it is added to the canvas"
	label isInACanvas ifFalse: [
		builder canvas addShape: label ]
]

{ #category : 'private' }
SaFlameGraph >> updateLabels [

	| scale |
	scale := self canvas camera scale.

	scale >= minimalScaleToShowText
		ifTrue: [
			| scaledFontSize |
			scaledFontSize := scale < 1.0
				ifTrue: [ logicalFontSize ]
				ifFalse: [ (logicalFontSize / scale) ceiling ].

			"Set label's fontSize and shrinked text
			(label may need to be added to canvas, too)"
			flameBoxes do: [ :each |
				self
					updateLabelOf: each
					scaledFontSize: scaledFontSize ] ]
		ifFalse: [
			"Just remove all labels"
			flameBoxes do: [ :each |
				(each propertyAt: flameLabelKey) remove ] ]

]
