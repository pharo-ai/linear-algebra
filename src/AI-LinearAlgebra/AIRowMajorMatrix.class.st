Class {
	#name : #AIRowMajorMatrix,
	#superclass : #AIAbstractMatrix,
	#type : #variable,
	#instVars : [
		'rows'
	],
	#category : #'AI-LinearAlgebra'
}

{ #category : #'instance creation' }
AIRowMajorMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	| theMatrix |
	theMatrix := self new: aNumberOfRows.
	1 to: aNumberOfRows do: [ :i | 
		theMatrix at: i put: (Array new: aNumberOfColumns) ].
	^ theMatrix
]

{ #category : #converting }
AIRowMajorMatrix >> asColumnMajor [

	^ self notYetImplemented
]

{ #category : #converting }
AIRowMajorMatrix >> asRowMajor [

	^ self
]

{ #category : #accessing }
AIRowMajorMatrix >> at: rowIndex at: columnIndex [

	^ (rows at: rowIndex) at: columnIndex
]

{ #category : #accessing }
AIRowMajorMatrix >> at: rowIndex at: columnIndex put: aValue [

	^ (rows at: rowIndex) at: columnIndex put: aValue
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ (rows at: rowIndex) at: columnIndex
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ (rows at: rowIndex) at: columnIndex put: aValue
]

{ #category : #operations }
AIRowMajorMatrix >> columnAverage [
	
	^ rows averageForMatrix
]

{ #category : #converting }
AIRowMajorMatrix >> initializeRows: aCollectionOfCollections [

	rows := aCollectionOfCollections
]

{ #category : #accessing }
AIRowMajorMatrix >> numberOfColumns [

	^ rows ifNotEmpty: [ rows first size ] ifEmpty: [ 0 ]
]

{ #category : #accessing }
AIRowMajorMatrix >> numberOfRows [

	^ rows size
]

{ #category : #'point functions' }
AIRowMajorMatrix >> transposed [

	| newMatrix |
	newMatrix := self class new: self numberOfColumns.

	(1 to: self numberOfColumns) do: [ :j | 
		newMatrix at: j put: (Array new: self numberOfRows).

		(1 to: self numberOfRows) do: [ :i | 
			newMatrix at: j at: i put: (self at: i at: j) ] ].
	
	^ newMatrix
]
