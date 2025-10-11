"
I convert a Duration to a String in a human readable representation.

My algorithm to write has this criteria:
* searching a representation without too many decimal digits;
* truncating the less significant part;
* using unit abbreviations

"
Class {
	#name : 'SaAdaptedDurationPrinter',
	#superclass : 'SaDurationPrinter',
	#category : 'Sauco-Core',
	#package : 'Sauco-Core'
}

{ #category : 'printing' }
SaAdaptedDurationPrinter >> print: aDuration on: stream [
	"Write a short human readable representation by:
		* truncating less significant part
		* using unit abbreviations 
		
	Inspired on Duration>>#printHumanReadableOn:
	"

	aDuration negative 
		ifTrue: [ 
			stream << '- '. 
			^ self print: aDuration abs on: stream ].
	#( (hours 'h') 
		(minutes 'm') 
		(seconds 's') 
		(asMilliSeconds 'ms') 
		(asMicroseconds 'us') 
		(asNanoSeconds 'ns')) do: [ :pair |
		| count |
		count := aDuration perform: pair first.
		count >= 1
			ifTrue: [
				count printOn: stream.
				stream << pair second.
				^ self ] ].
	stream << '0ns'

]
