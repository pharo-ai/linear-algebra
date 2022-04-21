Class {
	#name : #AILeastSquaresTest,
	#superclass : #TestCase,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #tests }
AILeastSquaresTest >> testSolutionIntelFortranExample [

	| fixture algo |
	fixture := AILeastSquaresFixtureIntelFortran new.
	
	algo := AILeastSquares new
		matrixA: fixture matrixA;
		matrixB: fixture matrixB;
		yourself.
		
	algo solve.
	self assert: algo solution equals: fixture matrixX.
]

{ #category : #tests }
AILeastSquaresTest >> testSolutionSmallExampleOneSolution [

	| fixture algo |
	fixture := AILeastSquaresFixtureSmallOneSolution new.
	
	algo := AILeastSquares new
		matrixA: fixture matrixA;
		matrixB: fixture matrixB;
		yourself.
		
	algo solve.
	self assert: algo solution equals: fixture matrixX.
]
