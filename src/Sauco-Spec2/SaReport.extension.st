Extension { #name : 'SaReport' }

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Behaviors'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allBehaviorNodes
]

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForCategories: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Categories'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allCategoryNodes
]

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForMethodLeaves: aBuilder [
	<inspectorPresentationOrder: 0.6 title: 'Method Leaves'>

	^ aBuilder newTable
		items: self methodNodeLeaves;
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | SaConvenience ratioIcon: each netTallyRatio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SaConvenience codeNameMorphFor: each ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ' ' join: each nameTags ])
]

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Methods'>

	^ SaConvenience
		inspectionCodeList: aBuilder
		items: self allMethodNodes
]

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForNetRanking: aBuilder [
	<inspectorPresentationOrder: 0.7 title: 'Tally Leaves'>

	| topTen |
	topTen := ((self allTallyNodes reject:[:each | each netTally isZero ]) sorted: [ :a :b | a netTally > b netTally ]).

	^ aBuilder newTable
		items: topTen;
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | SaConvenience ratioIcon: each ratio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Net Tally'
			evaluated: [ :each | each netTally ]);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SaConvenience codeNameMorphFor: each methodNode ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Category'
			evaluated: [ :each | each categoryName ]);
		addColumn: (SpStringTableColumn
			title: 'Is leaf?'
			evaluated: [ :each | each hasChildren ifTrue: [ 'No' ] ifFalse: [ 'Yes' ] ]);
		yourself
]

{ #category : '*Sauco-Spec2' }
SaReport >> inspectionForTallyTree: aBuilder [
	<inspectorPresentationOrder: 0.1 title: 'Tally tree'>

	| sortingBlock |
	sortingBlock := [ :a :b | a tally > b tally ].

	^ aBuilder newTree
		hideColumnHeaders;
		roots: (rootTallyNodes sorted: sortingBlock);
		expandRoots;
		displayIcon: [ :each | SaConvenience ratioIcon: each ratio ];
		display: [ :each | SaConvenience tallyNodeMorphFor: each ];
		children: [ :each | each children sorted: sortingBlock ];
		yourself

]
