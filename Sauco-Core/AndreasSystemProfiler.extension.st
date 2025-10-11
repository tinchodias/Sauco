Extension { #name : 'AndreasSystemProfiler' }

{ #category : '*Sauco-Core' }
AndreasSystemProfiler >> saucoAsReport [
	^ SaBuilder new
		tallyRoot: tallyRoot;
		totalTime: totalTime;
		build;
		report
]
