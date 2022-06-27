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
		numberOfRightHandSides: matrixB numberOfColumns;
		matrixA: matrixA;
		matrixB: matrixB;
		yourself.
	
	lapack solve.
	
	solution := AIPharoFloatContiguousColumnMajorMatrix
		values: lapack minimumNormSolution
		rows: matrixB numberOfColumns
		columns: matrixA numberOfColumns.
		
	singularValues := lapack singularValues.
	rank := lapack rank.
]
