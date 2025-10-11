Class {
	#name : 'SaReportTest',
	#superclass : 'SaTest',
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'testing' }
SaReportTest >> testAllBehaviorNodes [
	self
		assert: report allBehaviorNodes asSet
		equals:
			{self behaviorP.
			self behaviorQ} asSet
]

{ #category : 'testing' }
SaReportTest >> testAllCategoryNodes [
	self
		assert: report allCategoryNodes asSet
		equals:
			{self categoryH.
			self categoryI} asSet
]

{ #category : 'testing' }
SaReportTest >> testAllMethodNodes [
	self
		assert: report allMethodNodes asSet
		equals:
			{self methodX.
			self methodY.
			self methodZ} asSet
]

{ #category : 'testing' }
SaReportTest >> testTallyLeaves [

	self
		assert: (report tallyLeaves collect: [ :n | n methodNode ])
		equals: { 
				self methodY.
				self methodZ }
]
