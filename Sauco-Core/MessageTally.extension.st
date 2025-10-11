Extension { #name : 'MessageTally' }

{ #category : '*Sauco-Core' }
MessageTally >> saucoAsReport [
	^ SaBuilder new
		tallyRoot: self;
		totalTime: time;
		build;
		report
]
