Extension { #name : #Collection }

{ #category : #'*AI-LinearAlgebra' }
Collection >> asAIColumnMajorMatrix [
	
	^ self asAIMatrix: AIPharoFloatContiguousColumnMajorMatrix
]

{ #category : #'*AI-LinearAlgebra' }
Collection >> asAIMatrix [
	

	^ self asAIRowMajorMatrix
]

{ #category : #'*AI-LinearAlgebra' }
Collection >> asAIMatrix: aMatrixClass [
	"If I am a two-dimensional collection, return a matrix with same shape.
	If I am one-dimensional, return a column matrix"
	self ifEmpty: [ ^ aMatrixClass new ].
	self anyOne isCollection ifTrue: [ ^ aMatrixClass rows: self ].
	
	^ aMatrixClass values: self rows: self size columns: 1
]

{ #category : #'*AI-LinearAlgebra' }
Collection >> asAIRowMajorMatrix [
	"If I am a two-dimensional collection, return a matrix with same shape.
	If I am one-dimensional, return a column matrix"
	self ifEmpty: [ ^ AIRowMajorMatrix new ].
	self anyOne isCollection ifTrue: [ ^ AIRowMajorMatrix rows: self ].
	
	^ AIRowMajorMatrix values: self rows: self size columns: 1
]
