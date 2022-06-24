Class {
	#name : #AIColumnMajorMatrix,
	#superclass : #AIAbstractMatrix,
	#type : #variable,
	#instVars : [
		'numberOfRows',
		'numberOfColumns',
		'contents'
	],
	#category : #'AI-LinearAlgebra'
}

{ #category : #'as yet unclassified' }
AIColumnMajorMatrix class >> newContents: contents rows: aNumberOfRows columns: aNumberOfColumns [

	^ self new
		contents: contents;
		numberOfRows: aNumberOfRows;
		numberOfColumns: aNumberOfColumns;
		yourself
]

{ #category : #'as yet unclassified' }
AIColumnMajorMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: (Float64Array new: aNumberOfColumns * aNumberOfRows)
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #'as yet unclassified' }
AIColumnMajorMatrix class >> values: flattenedCollection rows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: flattenedCollection
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #operating }
AIColumnMajorMatrix >> -= aCollection [ 
	
	"Assume a collection is a matrix of one row"
	1 to: numberOfRows do: [ :row |
		1 to: numberOfColumns do: [ :column | | me |
			me := self atRow: row atColumn: column.
			self atRow: row atColumn: column put: (me - (aCollection at: column))
		]
	]
]

{ #category : #converting }
AIColumnMajorMatrix >> asArray [
	
	^ contents
]

{ #category : #converting }
AIColumnMajorMatrix >> asColumnMajor [

	^ self
]

{ #category : #converting }
AIColumnMajorMatrix >> asRowMajor [

	^ self notYetImplemented
]

{ #category : #accessing }
AIColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex
]

{ #category : #accessing }
AIColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex put: aValue
]

{ #category : #accessing }
AIColumnMajorMatrix >> columnAt: columnIndex [

	"A column runs from (c-1*n)+1 to c*n"

	^ contents
		  copyFrom: columnIndex - 1 * numberOfRows + 1
		  to: columnIndex * numberOfRows
]

{ #category : #accessing }
AIColumnMajorMatrix >> columnAverage [
	
	| runningAverage |
	runningAverage := Float64Array new: numberOfColumns.
	1 to: numberOfColumns do: [ :column |
		runningAverage at: column put: (self columnAt: column) sum / numberOfRows
	].
	^ runningAverage
]

{ #category : #accessing }
AIColumnMajorMatrix >> contents [

	^ contents
]

{ #category : #accessing }
AIColumnMajorMatrix >> contents: anObject [

	contents := anObject
]

{ #category : #converting }
AIColumnMajorMatrix >> flattened [

	"I'm already in a flattened representation"
	^ self
]

{ #category : #accessing }
AIColumnMajorMatrix >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
AIColumnMajorMatrix >> numberOfColumns: anObject [

	numberOfColumns := anObject
]

{ #category : #accessing }
AIColumnMajorMatrix >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
AIColumnMajorMatrix >> numberOfRows: anObject [

	numberOfRows := anObject
]

{ #category : #'point functions' }
AIColumnMajorMatrix >> transposed [

	| newMatrix |
	newMatrix := self class new: self numberOfColumns.

	(1 to: self numberOfColumns) do: [ :j | 
		newMatrix at: j put: (Array new: self numberOfRows).

		(1 to: self numberOfRows) do: [ :i | 
			newMatrix at: j at: i put: (self at: i at: j) ] ].
	
	^ newMatrix
]
