Class {
	#name : 'SaCodeSunburst',
	#superclass : 'SaGraphBuilder',
	#instVars : [
		'categoryNodes'
	],
	#category : 'Sauco-Roassal',
	#package : 'Sauco-Roassal'
}

{ #category : 'building' }
SaCodeSunburst >> build [

	builder := RSSunburstBuilder new.

	builder sliceShape 
		withBorder;
		segmentSpacing: 1.
	
	builder strategy
		hasCenter: false;
		radialSpacing: 5.

	builder
		weight: [ :shape |
			shape model 
				ifNil: [ categoryNodes sum: #netTally ] "Workaround: virtual node is added by builder"
				ifNotNil: [ shape model netTally ] ];
		from: (self nodesToShow: categoryNodes)
			using: [ :node | self nodesToShow: node children ].

	builder build.

	builder shapes do: [ :shape | 
		shape addInteraction: self popupInteraction.
		shape removeInteractionIfPresent: RSDraggable.
		shape color: shape model codeColor ].

	builder canvas
		color: self theme backgroundColor;
		addInteraction: RSCanvasController new

]

{ #category : 'accessing' }
SaCodeSunburst >> categoryNodes: someSaCategoryNodes [

	categoryNodes := someSaCategoryNodes
]

{ #category : 'building' }
SaCodeSunburst >> nodesToShow: someNodes [
	"Answer a filtered and sorted list of SaCodeNodes.
	They are sorted by #fullName to help comparing visually one profile run with another."

	^ (someNodes select: [ :each | each netTallyRatio > 0 ] ) 
		sorted: [ :a :b | a fullName < b fullName ]

]
