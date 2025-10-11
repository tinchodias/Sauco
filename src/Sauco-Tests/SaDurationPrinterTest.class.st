"
A SaDurationPrinterTest is a test class for testing the behavior of SaDurationPrinter
"
Class {
	#name : 'SaDurationPrinterTest',
	#superclass : 'TestCase',
	#instVars : [
		'printer'
	],
	#category : 'Sauco-Tests',
	#package : 'Sauco-Tests'
}

{ #category : 'testing' }
SaDurationPrinterTest class >> isAbstract [

	^ self = SaDurationPrinterTest
]

{ #category : 'test' }
SaDurationPrinterTest >> assertPrinting: aDuration equals: aString [

	| output |
	output := printer print: aDuration.
	self assert: output equals: aString
]

{ #category : 'running' }
SaDurationPrinterTest >> printerClass [
	"Answer the class of the printer being tested."

	^ self subclassResponsibility
]

{ #category : 'running' }
SaDurationPrinterTest >> setUp [
	super setUp.
	
	printer := self printerClass new
]
