Class {
	#name : 'BaselineOfSauco',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSauco',
	#package : 'BaselineOfSauco'
}

{ #category : 'baselines' }
BaselineOfSauco >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			package: 'Sauco-Core';
			package: 'Sauco-Spec2'
				with: [ spec requires: #( 'Sauco-Core' ) ];
			package: 'Sauco-Roassal3'
				with: [ spec requires: #( 'Sauco-Spec2' ) ];
			package: 'Sauco-Tests'
				with: [ spec requires: #( 'Sauco-Core' ) ] ]
]
