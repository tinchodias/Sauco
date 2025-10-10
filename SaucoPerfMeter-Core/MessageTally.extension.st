Extension { #name : 'MessageTally' }

{ #category : '*SaucoPerfMeter-Core' }
MessageTally >> saucoAsReport [
	^ SaBuilder new
		tallyRoot: self;
		totalTime: time;
		build;
		report
]
