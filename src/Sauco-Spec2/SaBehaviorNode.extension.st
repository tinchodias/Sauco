Extension { #name : 'SaBehaviorNode' }

{ #category : '*Sauco-Spec2' }
SaBehaviorNode >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Methods'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self methodNodes
]

{ #category : '*Sauco-Spec2' }
SaBehaviorNode >> nameTags [

	^ { self categoryName }
]
