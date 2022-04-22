Extension { #name : #Collection }

{ #category : #'*AI-LinearAlgebra' }
Collection >> asAIMatrix [
	"If I am a two-dimensional collection, return a matrix with same shape.
	If I am one-dimensional, return a column matrix"
	self ifEmpty: [ ^ AIMatrix new ].
	self anyOne isCollection ifTrue: [ ^ AIMatrix rows: self ].
	
	^ AIMatrix values: self rows: self size columns: 1
]
