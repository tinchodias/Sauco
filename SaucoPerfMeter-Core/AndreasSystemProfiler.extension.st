Extension { #name : 'AndreasSystemProfiler' }

{ #category : '*SaucoPerfMeter-Core' }
AndreasSystemProfiler >> saucoAsReport [
	^ SaBuilder new
		tallyRoot: tallyRoot;
		totalTime: totalTime;
		build;
		report
]
