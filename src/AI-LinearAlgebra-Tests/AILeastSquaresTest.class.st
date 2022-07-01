Class {
	#name : #AILeastSquaresTest,
	#superclass : #TestCase,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #accessing }
AILeastSquaresTest class >> defaultPrecisionsForCloseToComparison [

	^ 0.01
]

{ #category : #tests }
AILeastSquaresTest >> testSolutionIntelFortranExample [

	| fixture algo |
	fixture := AILeastSquaresFixtureIntelFortran new.
	
	algo := AILeastSquares new
		matrixA: fixture matrixA;
		matrixB: fixture matrixB;
		yourself.
	
	algo solve.
	
	algo solution
		with: fixture matrixX contents
		do: [ :real :expected | self assert: real closeTo: expected ]
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
	
	self assert: algo solution equals: fixture matrixX contents
]
