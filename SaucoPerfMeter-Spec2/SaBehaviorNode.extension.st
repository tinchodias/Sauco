Extension { #name : 'SaBehaviorNode' }

{ #category : '*SaucoPerfMeter-Spec2' }
SaBehaviorNode >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Methods'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self methodNodes
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaBehaviorNode >> nameTags [

	^ { self categoryName }
]
