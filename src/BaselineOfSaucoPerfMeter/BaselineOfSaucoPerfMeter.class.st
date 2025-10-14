"
This is the old baseline, kept for backwards compatibility. Please use `BaselineOfSauco`.
"
Class {
	#name : 'BaselineOfSaucoPerfMeter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSaucoPerfMeter',
	#package : 'BaselineOfSaucoPerfMeter'
}

{ #category : 'baselines' }
BaselineOfSaucoPerfMeter >> baseline: spec [
	<baseline>

	spec for: #common do: [
		
		'BaselineOfSaucoPerfMeter is the old baseline, kept for backwards compatibility. Please use `BaselineOfSauco`.' traceCr.
		
		spec
			package: 'Sauco-Core';
			package: 'Sauco-Spec2'
				with: [ spec requires: #( 'Sauco-Core' ) ];
			package: 'Sauco-Roassal'
				with: [ spec requires: #( 'Sauco-Spec2' ) ];
			package: 'Sauco-Tests'
				with: [ spec requires: #( 'Sauco-Core' ) ] ]
]
