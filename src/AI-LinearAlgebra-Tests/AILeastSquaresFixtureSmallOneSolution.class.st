"
Small example of least squares system (AX = B) with one solution taken from here: https://textbooks.math.gatech.edu/ila/least-squares.html
"
Class {
	#name : #AILeastSquaresFixtureSmallOneSolution,
	#superclass : #AILeastSquaresFixture,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixA [

	matrixA := AIColumnMajorMatrix rows: #( #( 0 1.1 ) #( 1 0 ) #( 0 -0.2 ) )
]

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixB [

	matrixB := AIColumnMajorMatrix values: #( 1.1 -1.1 -0.2 ) rows: 3 columns: 1
]

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixX [

	matrixX := AIColumnMajorMatrix values: #( -1.1 1 ) rows: 2 columns: 1
]

{ #category : #accessing }
AILeastSquaresFixtureSmallOneSolution >> minimumNormSolutionColumns [

	^ 1
]

{ #category : #accessing }
AILeastSquaresFixtureSmallOneSolution >> minimumNormSolutionRows [

	^ 2
]
