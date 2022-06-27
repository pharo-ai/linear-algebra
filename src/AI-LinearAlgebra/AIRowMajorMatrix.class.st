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
AIRowMajorMatrix class >> new: numberOfRows [

	^ self new
		  initializeRows: (Array new: numberOfRows);
		  yourself
]

{ #category : #'instance creation' }
AIRowMajorMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	| theMatrix |
	theMatrix := self new: aNumberOfRows.
	1 to: aNumberOfRows do: [ :i | 
		theMatrix at: i put: (Array new: aNumberOfColumns) ].
	^ theMatrix
]

{ #category : #operating }
AIRowMajorMatrix >> -= aCollection [ 
	
	rows := rows collect: [ :row | row - aCollection ]
]

{ #category : #'private - accessing' }
AIRowMajorMatrix >> at: rowIndex put: aRow [

	^ rows at: rowIndex put: aRow
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ (rows at: rowIndex) at: columnIndex
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ (rows at: rowIndex) at: columnIndex put: aValue
]

{ #category : #operating }
AIRowMajorMatrix >> columnAverage [
	
	^ rows averageForMatrix
]

{ #category : #'transforming - lapack' }
AIRowMajorMatrix >> contentsForLapack [
	
	^ self transposed flattened asFFIExternalArrayOfType: 'double'
]

{ #category : #'private - transforming' }
AIRowMajorMatrix >> flattened [
	
	^ rows flattened
]

{ #category : #initialization }
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

{ #category : #'private - transforming' }
AIRowMajorMatrix >> transposed [

	| newMatrix |
	newMatrix := self class new: self numberOfColumns.

	(1 to: self numberOfColumns) do: [ :j | 
		newMatrix at: j put: (Array new: self numberOfRows).

		(1 to: self numberOfRows) do: [ :i | 
			newMatrix at: j at: i put: (self at: i at: j) ] ].
	
	^ newMatrix
]
