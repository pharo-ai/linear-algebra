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
	
	self assert: algo rank equals: fixture rank.
	
	algo singularValues asArray
		with: fixture singularValues
		do: [ :algoValue :fixtureValue | self assert: algoValue closeTo: fixtureValue ].
	
	"The minimun norm solution comes in form of an flat array in a column major way"
	1 to: fixture minimumNormSolutionRows do: [ :row |
		1 to: fixture minimumNormSolutionColumns do: [ :column |
			self
				assert:( algo solution atRow: row atColumn: column)
				closeTo: (fixture matrixX atRow: row atColumn: column) ] ]
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
	
	self assert: algo solution equals: fixture matrixX
]
