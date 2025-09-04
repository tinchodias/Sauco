Extension { #name : 'SaCodeNode' }

{ #category : '*SaucoPerfMeter-Spec2' }
SaCodeNode >> nameTags [

	^ self subclassResponsibility
]

{ #category : '*SaucoPerfMeter-Spec2' }
SaCodeNode >> relevanceDescription [

	^ '{1} [{2}]' format: { 
		  (SaConvenience printRatio: self netTallyRatio).
		  (report durationPrinter print: self netTime)
		}
]
