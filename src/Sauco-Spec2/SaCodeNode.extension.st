Extension { #name : 'SaCodeNode' }

{ #category : '*Sauco-Spec2' }
SaCodeNode >> nameTags [

	^ self subclassResponsibility
]

{ #category : '*Sauco-Spec2' }
SaCodeNode >> relevanceDescription [

	^ '{1} [{2}]' format: { 
		  (SaConvenience printRatio: self netTallyRatio).
		  (report durationPrinter print: self netTime)
		}
]
