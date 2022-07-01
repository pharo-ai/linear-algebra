Class {
	#name : #AIMatrixTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'matrixClass'
	],
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #'building suites' }
AIMatrixTest class >> testParameters [

	| m1 |
	m1 := ParametrizedTestMatrix new.
	m1 forSelector: #matrixClass addOptions: {
		"AINativeFloatContiguousColumnMajorMatrix."
		AIColumnMajorMatrix.
		AIRowMajorMatrix
	}.
	^ m1
]

{ #category : #accessing }
AIMatrixTest >> matrixClass [

	^ matrixClass
]

{ #category : #accessing }
AIMatrixTest >> matrixClass: anObject [

	matrixClass := anObject
]

{ #category : #tests }
AIMatrixTest >> testColumnAverage [

	| aiMatrix averages |
	aiMatrix := #( #( 1 2 3 4 ) #( 5 6 7 8 ) #( 9 10 11 12 ) ) asAIMatrix: matrixClass.

	averages := aiMatrix columnAverage.

	self assert: averages asArray equals: #( 5 6 7 8 )
]

{ #category : #tests }
AIMatrixTest >> testCreateMatrixFromRows [

	| matrix |
	matrix := matrixClass rows: #( #( 1 2 3 ) #( 4 5 6 ) ).

	self assert: (matrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (matrix atRow: 1 atColumn: 2) equals: 2.
	self assert: (matrix atRow: 1 atColumn: 3) equals: 3.

	self assert: (matrix atRow: 2 atColumn: 1) equals: 4.
	self assert: (matrix atRow: 2 atColumn: 2) equals: 5.
	self assert: (matrix atRow: 2 atColumn: 3) equals: 6
]

{ #category : #tests }
AIMatrixTest >> testCreateMatrixFromSizes [

	| matrix |
	matrix := matrixClass newRows: 2 columns: 3.

	self assert: (matrix atRow: 1 atColumn: 1) equals: matrix defaultElement.
	self assert: (matrix atRow: 2 atColumn: 3) equals: matrix defaultElement
]

{ #category : #tests }
AIMatrixTest >> testCreateMatrixFromValues [

	| matrix |
	matrix := matrixClass values: #( 1 2 3 4 5 6 ) rows: 2 columns: 3.

	self assert: (matrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (matrix atRow: 2 atColumn: 3) equals: 6
]

{ #category : #tests }
AIMatrixTest >> testRead [

	| aiMatrix |
	aiMatrix := matrixClass rows: #( #( 1 2 3 4 ) #( 5 6 7 8 ) #( 9 10 11 12 ) ).

	self assert: (aiMatrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (aiMatrix atRow: 1 atColumn: 2) equals: 2.
	self assert: (aiMatrix atRow: 1 atColumn: 3) equals: 3.
	self assert: (aiMatrix atRow: 1 atColumn: 4) equals: 4.

	self assert: (aiMatrix atRow: 2 atColumn: 1) equals: 5.
	self assert: (aiMatrix atRow: 2 atColumn: 2) equals: 6.
	self assert: (aiMatrix atRow: 2 atColumn: 3) equals: 7.
	self assert: (aiMatrix atRow: 2 atColumn: 4) equals: 8.

	self assert: (aiMatrix atRow: 3 atColumn: 1) equals: 9.
	self assert: (aiMatrix atRow: 3 atColumn: 2) equals: 10.
	self assert: (aiMatrix atRow: 3 atColumn: 3) equals: 11.
	self assert: (aiMatrix atRow: 3 atColumn: 4) equals: 12
]

{ #category : #tests }
AIMatrixTest >> testSubstractRow [

	| aiMatrix |
	aiMatrix := matrixClass rows: #( #( 1 2 3 4 ) #( 5 6 7 8 ) ).

	aiMatrix -= #( 2 5 8 1 ).

	self assert: (aiMatrix atRow: 1 atColumn: 1) equals: -1.
	self assert: (aiMatrix atRow: 1 atColumn: 2) equals: -3.
	self assert: (aiMatrix atRow: 1 atColumn: 3) equals: -5.
	self assert: (aiMatrix atRow: 1 atColumn: 4) equals: 3.

	self assert: (aiMatrix atRow: 2 atColumn: 1) equals: 3.
	self assert: (aiMatrix atRow: 2 atColumn: 2) equals: 1.
	self assert: (aiMatrix atRow: 2 atColumn: 3) equals: -1.
	self assert: (aiMatrix atRow: 2 atColumn: 4) equals: 7
]

{ #category : #tests }
AIMatrixTest >> testTransposed [

	| aiMatrix transposedMatrix |
	aiMatrix := matrixClass rows: #( #( 2 4 -1 ) #( -10 5 11 ) #( 18 -7 6 ) ).
	transposedMatrix := aiMatrix transposed.
	
	self assert: (transposedMatrix atRow: 1 atColumn: 1) equals: 2.
	self assert: (transposedMatrix atRow: 1 atColumn: 2) equals: -10.
	self assert: (transposedMatrix atRow: 1 atColumn: 3) equals: 18.

	self assert: (transposedMatrix atRow: 2 atColumn: 1) equals: 4.
	self assert: (transposedMatrix atRow: 2 atColumn: 2) equals: 5.
	self assert: (transposedMatrix atRow: 2 atColumn: 3) equals: -7.

	self assert: (transposedMatrix atRow: 3 atColumn: 1) equals: -1.
	self assert: (transposedMatrix atRow: 3 atColumn: 2) equals: 11.
	self assert: (transposedMatrix atRow: 3 atColumn: 3) equals: 6
]

{ #category : #tests }
AIMatrixTest >> testTransposedNonSquaredMatrix [

	| aiMatrix transposedMatrix |
	aiMatrix := matrixClass rows: #( #( 1 2 3 ) #( 4 5 6 ) #( 7 8 9 ) #( 10 11 12 ) ).
	transposedMatrix := aiMatrix transposed.

	self assert: (transposedMatrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (transposedMatrix atRow: 1 atColumn: 2) equals: 4.
	self assert: (transposedMatrix atRow: 1 atColumn: 3) equals: 7.
	self assert: (transposedMatrix atRow: 1 atColumn: 4) equals: 10.

	self assert: (transposedMatrix atRow: 2 atColumn: 1) equals: 2.
	self assert: (transposedMatrix atRow: 2 atColumn: 2) equals: 5.
	self assert: (transposedMatrix atRow: 2 atColumn: 3) equals: 8.
	self assert: (transposedMatrix atRow: 2 atColumn: 4) equals: 11.

	self assert: (transposedMatrix atRow: 3 atColumn: 1) equals: 3.
	self assert: (transposedMatrix atRow: 3 atColumn: 2) equals: 6.
	self assert: (transposedMatrix atRow: 3 atColumn: 3) equals: 9.
	self assert: (transposedMatrix atRow: 3 atColumn: 4) equals: 12
]

{ #category : #tests }
AIMatrixTest >> testWrite [

	| aiMatrix i |
	aiMatrix := matrixClass newRows: 3 columns: 4.

	i := 1.
	1 to: 3 do: [ :row | 
		1 to: 4 do: [ :column | 
			aiMatrix atRow: row atColumn: column put: i.
			i := i + 1 ] ].

	self assert: (aiMatrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (aiMatrix atRow: 1 atColumn: 2) equals: 2.
	self assert: (aiMatrix atRow: 1 atColumn: 3) equals: 3.
	self assert: (aiMatrix atRow: 1 atColumn: 4) equals: 4.

	self assert: (aiMatrix atRow: 2 atColumn: 1) equals: 5.
	self assert: (aiMatrix atRow: 2 atColumn: 2) equals: 6.
	self assert: (aiMatrix atRow: 2 atColumn: 3) equals: 7.
	self assert: (aiMatrix atRow: 2 atColumn: 4) equals: 8.

	self assert: (aiMatrix atRow: 3 atColumn: 1) equals: 9.
	self assert: (aiMatrix atRow: 3 atColumn: 2) equals: 10.
	self assert: (aiMatrix atRow: 3 atColumn: 3) equals: 11.
	self assert: (aiMatrix atRow: 3 atColumn: 4) equals: 12
]
