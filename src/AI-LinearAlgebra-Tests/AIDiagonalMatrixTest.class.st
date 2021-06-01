Class {
	#name : #AIDiagonalMatrixTest,
	#superclass : #TestCase,
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #tests }
AIDiagonalMatrixTest >> testAccessors [


	| m |
	m := AIDiagonalMatrix withDiagonal: #(3 4 5).
	
	self assert: (m at: 1 and: 1) equals: 3.
	self assert: (m at: 2 and: 1) equals: 0.
	self assert: (m at: 3 and: 3) equals: 5.
   
]

{ #category : #tests }
AIDiagonalMatrixTest >> testDimension [


	| m |
	m := AIDiagonalMatrix new: 5.
	self assert: m rowSize equals: 5.
	self assert: m columnSize equals: 5.

]

{ #category : #tests }
AIDiagonalMatrixTest >> testproductFromDiagonalMatrix [


	| aDiagonalMatrix aRowMatrix|
	aDiagonalMatrix := AIDiagonalMatrix withDiagonal: #(1 2).
	aRowMatrix := AIRowMatrix new rows: #( #(5 3) #(3 2)).
	aDiagonalMatrix := aDiagonalMatrix * aRowMatrix.
	self assert: (aDiagonalMatrix at: 1 and: 1) equals: 5.
	self assert: (aDiagonalMatrix at: 1 and: 2) equals: 0.
	self assert: (aDiagonalMatrix at: 2 and: 1) equals: 0.
	self assert: (aDiagonalMatrix at: 2 and: 2) equals: 4.

]
