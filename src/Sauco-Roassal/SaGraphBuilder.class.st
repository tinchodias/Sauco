Class {
	#name : 'SaGraphBuilder',
	#superclass : 'Object',
	#instVars : [
		'builder',
		'report'
	],
	#category : 'Sauco-Roassal',
	#package : 'Sauco-Roassal'
}

{ #category : 'building' }
SaGraphBuilder >> build [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
SaGraphBuilder >> canvas [
	"Answer a RSCanvas, that was built previously by sending #build (precondition)."

	^ builder canvas
]

{ #category : 'private' }
SaGraphBuilder >> highlightInteraction [

	^ RSHighlightable new
		  highlightBorder: (RSBorder new
				   width: 2;
				   color: self theme textColor);
		  yourself
]

{ #category : 'private' }
SaGraphBuilder >> popupInteraction [

	| popup |
	popup := RSPopup new.

	popup shapeBuilder textBlock: [ :n | 
		SaConvenience multipleLineDescriptionFor: n ].

	popup shapeBuilder labelBuilder labelShape
		color: self theme textColor.

	popup shapeBuilder boxBuilder
		color: self theme backgroundColor;
		border:
			(RSBorder new
				color: self theme borderColor;
				width: 0.5;
				yourself).

	^ popup
]

{ #category : 'accessing' }
SaGraphBuilder >> report [

	^ report
]

{ #category : 'accessing' }
SaGraphBuilder >> report: aSaReport [

	report := aSaReport
]

{ #category : 'private' }
SaGraphBuilder >> theme [

	^ report colorMap theme
]
