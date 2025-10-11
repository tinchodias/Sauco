Class {
	#name : 'SaBuilderTest',
	#superclass : 'TestCase',
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'tests' }
SaBuilderTest >> doSomething [
	
	100 milliSeconds wait
]

{ #category : 'tests' }
SaBuilderTest >> testAndreasSystemProfilerAsReport [
	| profiler report |
	"Profile"
	profiler := AndreasSystemProfiler new.
	profiler startProfiling.
	self doSomething.
	profiler stopProfiling.
	"Asserts on resulting report"
	report := profiler saucoAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty.
	report rootTallyNodes do: [ :each | 
		self assert: each parent isNil ].
]

{ #category : 'tests' }
SaBuilderTest >> testMessageTallyAsReport [
	| profiler report |
	"Profile"
	profiler := MessageTally new.
	profiler spyEvery: 1 on: [ self doSomething ].
	"Asserts on resulting report"
	report := profiler saucoAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty.
	report rootTallyNodes do: [ :each | 
		self assert: each parent isNil ].
]
