Class {
	#name : #AILeastSquares,
	#superclass : #Object,
	#instVars : [
		'matrixA',
		'matrixB',
		'solution',
		'singularValues',
		'rank'
	],
	#category : #'AI-LinearAlgebra'
}

{ #category : #accessing }
AILeastSquares >> matrixA: aMatrix [

	matrixA := aMatrix
]

{ #category : #accessing }
AILeastSquares >> matrixB: aMatrix [

	matrixB := aMatrix
]

{ #category : #accessing }
AILeastSquares >> rank [

	^ rank
]

{ #category : #accessing }
AILeastSquares >> singularValues [

	^ singularValues
]

{ #category : #accessing }
AILeastSquares >> solution [

	^ solution
]

{ #category : #solving }
AILeastSquares >> solve [

	| lapack |
	
	lapack := LapackDgelsd new
		numberOfRows: matrixA size;
		numberOfColumns: matrixA first size;
		numberOfRightHandSides: matrixB first size;
		matrixA: matrixA flattened;
		matrixB: matrixB flattened;
		yourself.
	
	lapack solve.
	
	solution := lapack minimumNormSolution.
	singularValues := lapack singularValues.
	rank := lapack rank.
]
