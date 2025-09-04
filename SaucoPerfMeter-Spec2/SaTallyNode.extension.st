Extension { #name : 'SaTallyNode' }

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> inspectionForAllParents: aBuilder [
	<inspectorPresentationOrder: 0.2 title: 'Call Stack'>

	^ aBuilder newTable
		items: self withAllParents;
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | SaConvenience ratioIcon: each ratio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SaConvenience codeNameMorphFor: each methodNode ])
			width: 400;
			yourself);
		yourself
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Behaviors'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allBehaviorNodes
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> inspectionForCategories: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Categories'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allCategoryNodes
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Methods'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allMethodNodes
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> inspectionForSource: aBuilder [
	<inspectorPresentationOrder: 0.1 title: 'Source in current image'>

	^ methodNode inspectionForSource: aBuilder
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaTallyNode >> relevanceDescription [

	^ String streamContents: [ :stream |
		stream
			<< (SaConvenience printRatio: self ratio);
			<< ' of total'.

		self hasParent ifTrue: [
			stream
				<< ' (';
				<< (SaConvenience printRatio: self parentRatio);
				<< ' of parent)' ].

		stream
			<< ' -- ';
			<< (report durationPrinter print: self time).

		(self hasChildren and: [ self netTally > 0 ]) ifTrue: [
			stream
				<< ' (';
				<< (report durationPrinter print: self netTime);
				<< ' net)' ].
		 ]
]
