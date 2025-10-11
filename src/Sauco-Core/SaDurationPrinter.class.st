"
I know how to convert a Duration to a String.

"
Class {
	#name : 'SaDurationPrinter',
	#superclass : 'Object',
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'printing' }
SaDurationPrinter >> print: aDuration [

	^ String streamContents: [ :stream | 
		  self print: aDuration on: stream ]
]

{ #category : 'printing' }
SaDurationPrinter >> print: aDuration on: stream [

	^ self subclassResponsibility
]
