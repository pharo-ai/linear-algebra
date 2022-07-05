"
An example of least squares system (AX = B) taken from Intel DGELSD Example Program in Fortran:
https://www.intel.com/content/www/us/en/develop/documentation/onemkl-lapack-examples/top/least-squares-and-eigenvalue-problems/linear-least-squares-lls-problems/gelsd-function/dgelsd-example/dgelsd-example-fortran.html

Same example but calling Fortran from C:
https://www.intel.com/content/www/us/en/develop/documentation/onemkl-lapack-examples/top/least-squares-and-eigenvalue-problems/linear-least-squares-lls-problems/gelsd-function/dgelsd-example/lapacke-dgelsd-example-c-row.html
"
Class {
	#name : #AILeastSquaresFixtureIntelFortran,
	#superclass : #AILeastSquaresFixture,
	#instVars : [
		'singularValues',
		'rank'
	],
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initialize [

	super initialize.
	self initializeSingularValues.
	self initializeRank
]

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initializeMatrixA [

	matrixA := #(
		#( 0.12 -8.19 7.69 -2.26 -4.71 )
		#( -6.91 2.22 -5.12 -9.08 9.96 )
		#( -3.33 -8.94 -6.72 -4.40 -9.98 )
		#( 3.97 3.33 -2.74 -7.92 -3.20 ) ) asAIColumnMajorMatrix
"	matrixA := AIColumnMajorMatrix
		values: #( 0.12 -8.19  7.69 -2.26 -4.71
   					 -6.91  2.22 -5.12 -9.08  9.96
                -3.33 -8.94 -6.72 -4.40 -9.98
                 3.97  3.33 -2.74 -7.92 -3.20 )
		rows: 4
		columns: 5"
]

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initializeMatrixB [

	matrixB := #(
		#( 7.30 0.47 -6.28 )
		#( 1.33 6.58 -3.42 )
		#( 2.68 -1.71 3.46 )
		#( -9.62 -0.79 0.41 ) ) asAIColumnMajorMatrix
	"matrixB := AIColumnMajorMatrix
		values: #(7.30  0.47 -6.28
                1.33  6.58 -3.42
                2.68 -1.71  3.46
               -9.62 -0.79  0.41)
		rows: 4
		columns: 3"
]

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initializeMatrixX [

	matrixX := #(
		#( -0.685765 -0.289427 -0.017234 )
		#( -0.795005 -0.482921 -0.146637 )
	   #( 0.376681 0.511976 0.264648 )
		#( 0.288496 0.196115 -0.176728 )
	   #( 0.291609 0.177127 0.036823 ) ) asAIColumnMajorMatrix
]

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initializeRank [

	rank := 4
]

{ #category : #initialization }
AILeastSquaresFixtureIntelFortran >> initializeSingularValues [

	singularValues := #( 18.66 15.99 10.01 8.51 )
]

{ #category : #accessing }
AILeastSquaresFixtureIntelFortran >> minimumNormSolutionColumns [

	^ 3
]

{ #category : #accessing }
AILeastSquaresFixtureIntelFortran >> minimumNormSolutionRows [

	^ 5
]

{ #category : #accessing }
AILeastSquaresFixtureIntelFortran >> rank [

	^ rank
]

{ #category : #accessing }
AILeastSquaresFixtureIntelFortran >> singularValues [

	^ singularValues
]
