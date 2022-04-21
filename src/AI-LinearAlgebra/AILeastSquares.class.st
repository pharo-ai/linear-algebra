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
		numberOfRows: matrixA numberOfRows;
		numberOfColumns: matrixA numberOfColumns;
		numberOfRightHandSides: matrixB numberOfRows;
		matrixA: matrixA flattened;
		matrixB: matrixB flattened;
		yourself.
	
	lapack solve.
	
	solution := AIMatrix
		values: lapack minimumNormSolution
		rows: matrixA numberOfColumns
		columns: matrixB numberOfRows.
		
	singularValues := lapack singularValues.
	rank := lapack rank.
]
