Class {
	#name : #AIColumnMajorMatrixTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'matrixClass'
	],
	#category : #'AI-LinearAlgebra-Tests'
}

{ #category : #tests }
AIColumnMajorMatrixTest class >> testParameters [

	| m1 |
	m1 := ParametrizedTestMatrix new.
	m1 forSelector: #matrixClass addOptions: { AIPharoFloatContiguousColumnMajorMatrix. AIRowMajorMatrix }.
	^ m1
]

{ #category : #accessing }
AIColumnMajorMatrixTest >> matrixClass [

	^ matrixClass
]

{ #category : #accessing }
AIColumnMajorMatrixTest >> matrixClass: anObject [

	matrixClass := anObject
]

{ #category : #tests }
AIColumnMajorMatrixTest >> testRead [

	| aiMatrix |
	aiMatrix := #( (1 2 3) (4 5 6) (7 8 9) ) asAIMatrix: matrixClass.
	
	self assert: (aiMatrix atRow: 1 atColumn: 1) equals: 1.
	self assert: (aiMatrix atRow: 1 atColumn: 2) equals: 2.
	self assert: (aiMatrix atRow: 1 atColumn: 3) equals: 3.
	self assert: (aiMatrix atRow: 2 atColumn: 1) equals: 4.
	self assert: (aiMatrix atRow: 2 atColumn: 2) equals: 5.
	self assert: (aiMatrix atRow: 2 atColumn: 3) equals: 6.
	self assert: (aiMatrix atRow: 3 atColumn: 1) equals: 7.
	self assert: (aiMatrix atRow: 3 atColumn: 2) equals: 8.
	self assert: (aiMatrix atRow: 3 atColumn: 3) equals: 9.
]
