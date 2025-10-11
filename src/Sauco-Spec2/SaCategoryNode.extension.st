Extension { #name : 'SaCategoryNode' }

{ #category : '*Sauco-Spec2' }
SaCategoryNode >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Behaviors'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self behaviorNodes
]

{ #category : '*Sauco-Spec2' }
SaCategoryNode >> nameTags [

	^ #(  )
]
