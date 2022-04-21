Class {
	#name : #AIMatrix,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'matrixA',
		'matrixB',
		'solution',
		'singularValues',
		'rank'
	],
	#category : #'AI-LinearAlgebra'
}

{ #category : #'as yet unclassified' }
AIMatrix class >> rows: aCollectionOfCollections [

	^ (self new: aCollectionOfCollections size)
		initializeRows: aCollectionOfCollections;
		yourself.
]

{ #category : #'as yet unclassified' }
AIMatrix class >> values: aCollection rows: aNumberOfRows columns: aNumberOfColumns [

	| rows index |
	
	rows := (1 to: aNumberOfRows) collect: [ :i |
		(1 to: aNumberOfColumns) collect: [ :j |
			index := (i - 1) * aNumberOfColumns + j.
			aCollection at: index ] ].
	
	^ self rows: rows.
]

{ #category : #initialization }
AIMatrix >> initializeRows: aCollectionOfCollections [

	aCollectionOfCollections withIndexCollect: [ :row :index |
		self at: index put: row asArray ].
]

{ #category : #accessing }
AIMatrix >> numberOfColumns [

	^ self ifNotEmpty: [ self first size ] ifEmpty: [ 0 ]
]

{ #category : #accessing }
AIMatrix >> numberOfRows [

	^ self size
]
