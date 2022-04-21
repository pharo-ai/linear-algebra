Class {
	#name : #AILeastSquaresTest,
	#superclass : #TestCase,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #tests }
AILeastSquaresTest >> testSolutionSmallOneSolution [

	| fixture algo |
	fixture := AILeastSquaresFixtureSmallOneSolution new.
	
	algo := AILeastSquares new
		matrixA: fixture matrixA;
		matrixB: fixture matrixB;
		yourself.
		
	algo solve.
	self assert: algo solution equals: fixture matrixX.
]
