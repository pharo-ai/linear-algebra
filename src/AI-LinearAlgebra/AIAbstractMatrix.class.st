Class {
	#name : #AIAbstractMatrix,
	#superclass : #Object,
	#type : #variable,
	#category : #'AI-LinearAlgebra'
}

{ #category : #'instance creation' }
AIAbstractMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AIAbstractMatrix class >> rows: rowMajorNonFlattenedMatrix [

	| flattenedFloatArray |
	flattenedFloatArray := Float64Array streamContents: [ :stream |
		(AIMatrix rows: rowMajorNonFlattenedMatrix) transposed flattenOn: stream ].
	^ self
		values: flattenedFloatArray
		rows: rowMajorNonFlattenedMatrix size
		columns: rowMajorNonFlattenedMatrix first size
]

{ #category : #'as yet unclassified' }
AIAbstractMatrix class >> values: aCollection rows: aNumberOfRows columns: aNumberOfColumns [

	| rows index |
	rows := (1 to: aNumberOfRows) collect: [ :i | 
		        (1 to: aNumberOfColumns) collect: [ :j | 
			        index := i - 1 * aNumberOfColumns + j.
			        aCollection at: index ] ].

	^ (self newRows: aNumberOfRows columns: aNumberOfColumns)
		  initializeRows: rows;
		  yourself
]

{ #category : #initialization }
AIAbstractMatrix >> initializeRows: aCollectionOfCollections [

	aCollectionOfCollections withIndexCollect: [ :row :rowIndex | 
		row withIndexCollect: [ :value :columnIndex | 
			self atRow: rowIndex atColumn: columnIndex put: value ] ]
]
