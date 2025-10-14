Extension { #name : 'SaTallyNode' }

{ #category : '*Sauco-Roassal' }
SaTallyNode >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Children flame graph (no pruning)'>

	| canvas |
	canvas :=
		SaFlameGraph new
		   considerAllNodes;
		   report: report;
		   tallyNodes: { self };
		   build;
		   canvas.

	canvas addInteraction: RSCanvasController new.

	^ (aBuilder instantiate: SpRoassalInspectorPresenter)
		canvas: canvas;
		yourself
]
