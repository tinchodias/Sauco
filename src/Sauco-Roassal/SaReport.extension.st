Extension { #name : 'SaReport' }

{ #category : '*Sauco-Roassal' }
SaReport >> asFlameGraph [
	"Answer a new Roassal canvas with a flame graph visualization to navigate this report (with a `RSCanvasController`)."

	| canvas |
	canvas := self asRSCanvas.

	canvas addInteraction: RSCanvasController new.

	^ canvas
]

{ #category : '*Sauco-Roassal' }
SaReport >> asRSCanvas [

	^ SaFlameGraph new
		  report: self;
		  tallyNodes: rootTallyNodes;
		  build;
		  canvas
]

{ #category : '*Sauco-Roassal' }
SaReport >> inspectionCodeSunburstIn: aBuilder [
"	<inspectorPresentationOrder: 0.6 title: 'Tally Distribution'>"
	
	self flag: #todo. "Delete? wasn't useful"
	
	^ (SaCodeSunburst new
			report: self;
			categoryNodes: self allCategoryNodes;
			build;
			canvas) asPresenter
]

{ #category : '*Sauco-Roassal' }
SaReport >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph (prune irrelevant children)'>

	^ self asFlameGraph asPresenter
]
