Extension { #name : 'SaCategoryNode' }

{ #category : '*SaucoPerfMeter-Spec2' }
SaCategoryNode >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Behaviors'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self behaviorNodes
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaCategoryNode >> nameTags [

	^ #(  )
]
