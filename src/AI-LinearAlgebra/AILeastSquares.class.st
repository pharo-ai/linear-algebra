"
I am a class that solves the least square problem using lapack. To use me, you need to have lapack installed on your system.

To use me, you need to set the matrixA and matrixB. Those objects, need to be an instance of AIColumnMajorMatrix because that object understand the message `contentsForLapack` and `contentsForLapackOfAtLeast:`

Actually you can use any object that understands the messages `contentsForLapack` and `contentsForLapackOfAtLeast:`

I am currently in developing so I will probably change in time
"
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

	"solution := lapack minimumNormSolution asArray."
	solution := AIColumnMajorMatrix
		"values: (lapack minimumNormSolution asArray first: matrixA numberOfColumns)"
		values: lapack minimumNormSolution asArray
		rows: matrixA numberOfColumns
		columns: matrixB numberOfColumns.

	singularValues := lapack singularValues.
	rank := lapack rank
]
