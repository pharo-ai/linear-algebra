"
I am the abstract class for the fixture example for testing lapack least squares algorithm
"
Class {
	#name : #AILeastSquaresFixture,
	#superclass : #Object,
	#instVars : [
		'matrixA',
		'matrixB',
		'matrixX'
	],
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #initialization }
AILeastSquaresFixture >> initialize [ 
	super initialize.
	self initializeMatrixA.
	self initializeMatrixB.
	self initializeMatrixX.
]

{ #category : #initialization }
AILeastSquaresFixture >> initializeMatrixA [

	self subclassResponsibility
]

{ #category : #initialization }
AILeastSquaresFixture >> initializeMatrixB [

	self subclassResponsibility
]

{ #category : #initialization }
AILeastSquaresFixture >> initializeMatrixX [

	self subclassResponsibility
]

{ #category : #accessing }
AILeastSquaresFixture >> matrixA [

	^ matrixA
]

{ #category : #accessing }
AILeastSquaresFixture >> matrixB [

	^ matrixB
]

{ #category : #accessing }
AILeastSquaresFixture >> matrixX [

	^ matrixX
]
