Class {
	#name : #AILeastSquaresFixtureSmallOneSolution,
	#superclass : #AILeastSquaresFixture,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initialize [ 
	super initialize.
]

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixA [

	matrixA := #(
		(0 1.1)
		(1 0)
		(0 -0.2)) asAIMatrix.
]

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixB [

	matrixB := #(1.1 -1.1 -0.2) asAIMatrix.
]

{ #category : #initialization }
AILeastSquaresFixtureSmallOneSolution >> initializeMatrixX [

	matrixX := #(-1.1 1) asAIMatrix.
]
