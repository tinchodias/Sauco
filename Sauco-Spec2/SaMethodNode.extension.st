Extension { #name : 'SaMethodNode' }

{ #category : '*Sauco-Spec2' }
SaMethodNode >> inspectionForSource: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Source in current image'>

	^ self
		  compiledMethodInCurrentImageIfPresent: [ :method | 
			  method inspectionSource: aBuilder ]
		  ifAbsent: [ 
			  aBuilder newLabel
				  label: '-- Not found --';
				  yourself ]
]

{ #category : '*Sauco-Spec2' }
SaMethodNode >> inspectionForTallyNodes: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Tally Nodes'>

	| topTen |
	topTen := tallyNodes sorted: [ :a :b | a netTally > b netTally ].

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
		addColumn: (SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SaConvenience codeNameMorphFor: each methodNode ]);
		addColumn: (SpStringTableColumn
			title: 'Category'
			evaluated: [ :each | each methodNode categoryName ]);
		addColumn: (SpStringTableColumn
			title: 'Is leaf?'
			evaluated: [ :each | each hasChildren ifTrue: [ 'No' ] ifFalse: [ 'Yes' ] ]);
		yourself
]

{ #category : '*Sauco-Spec2' }
SaMethodNode >> nameTags [

	^ { self categoryName }
]
