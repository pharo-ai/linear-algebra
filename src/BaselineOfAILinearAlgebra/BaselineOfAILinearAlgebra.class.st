Class {
	#name : #BaselineOfAILinearAlgebra,
	#superclass : #BaselineOf,
	#category : #BaselineOfAILinearAlgebra
}

{ #category : #baselines }
BaselineOfAILinearAlgebra >> baseline: spec [
	<baseline>
	spec for: #common do: [
		"External dependencies"
		spec
			baseline: 'Lapack'
			with: [ spec repository: 'github://pharo-ai/lapack/src' ].
		
		"Packages"
		spec 
			package: 'AI-LinearAlgebraDataStructures';
			package: 'AI-LinearAlgebra' with: [ spec requires: #('Lapack' 'AI-LinearAlgebraDataStructures') ];
			package: 'AI-LinearAlgebra-Tests' with: [ spec requires: #('AI-LinearAlgebra') ] ].
]
