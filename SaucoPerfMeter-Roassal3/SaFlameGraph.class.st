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
		'minimalLabelWidth',
		'shrinkPace',
		'minimalScaleToShowText'
	],
	#category : 'SaucoPerfMeter-Roassal3',
	#package : 'SaucoPerfMeter-Roassal3'
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
		addInteraction: RSCanvasController new;
		when: RSScaleChangedEvent
			send: #onCanvasScaled:
			to: self.

	"Additional setup for the box shapes"
	flameBoxes := builder shapes.
	flameBoxes do: [ :eachFlameBox |
		eachFlameBox
			color: eachFlameBox model methodNode codeColor;
			addInteraction: RSKeepBorderWidthRatioInteraction ].

	"Prepare the labels, that will be added depending on the camera scale"
	flameBoxes do: [ :eachFlameBox |
		| label |
		label := RSLabel new.
		label position: eachFlameBox position.
		eachFlameBox propertyAt: flameLabelKey put: label ]
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
	shrinkPace := 3.

	flameLabelKey := #FlameLabel.

	flameBoxPadding := 4 @ 10.
	minimalLabelWidth := 10.

	minimalScaleToShowText := 0.7.
	logicalFontSize := 10.

	self considerOnlyRelevantNodes
]

{ #category : 'private' }
SaFlameGraph >> onCanvasScaled: anEvent [

	self updateLabels.

	anEvent signalUpdate
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

	builder boxShape
		cornerRadius: 0;
		border:
			(RSBorder new
			  width: 0.5;
			  color: self theme textColor;
			  yourself);
		addInteraction: self popupInteraction;
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

	"position: aFlameBox position --> to center".
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
			scaledFontSize := (logicalFontSize / scale) ceiling.

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
