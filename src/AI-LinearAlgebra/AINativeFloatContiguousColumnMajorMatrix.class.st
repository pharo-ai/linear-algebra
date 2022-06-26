Class {
	#name : #AINativeFloatContiguousColumnMajorMatrix,
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
AINativeFloatContiguousColumnMajorMatrix class >> newContents: contents rows: aNumberOfRows columns: aNumberOfColumns [

	^ self new
		contents: contents;
		numberOfRows: aNumberOfRows;
		numberOfColumns: aNumberOfColumns;
		yourself
]

{ #category : #'as yet unclassified' }
AINativeFloatContiguousColumnMajorMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: (Array new: aNumberOfColumns * aNumberOfRows)
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #'as yet unclassified' }
AINativeFloatContiguousColumnMajorMatrix class >> values: flattenedCollection rows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: flattenedCollection
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #operating }
AINativeFloatContiguousColumnMajorMatrix >> -= aCollection [ 
	
	"Assume a collection is a matrix of one row"
	1 to: numberOfRows do: [ :row |
		1 to: numberOfColumns do: [ :column | | me |
			me := self atRow: row atColumn: column.
			self atRow: row atColumn: column put: (me - (aCollection at: column))
		]
	]
]

{ #category : #converting }
AINativeFloatContiguousColumnMajorMatrix >> asArray [
	
	^ contents
]

{ #category : #converting }
AINativeFloatContiguousColumnMajorMatrix >> asColumnMajor [

	^ self
]

{ #category : #converting }
AINativeFloatContiguousColumnMajorMatrix >> asRowMajor [

	^ self notYetImplemented
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex put: aValue
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> columnAt: columnIndex [

	"A column runs from (c-1*n)+1 to c*n"

	^ contents
		  copyFrom: columnIndex - 1 * numberOfRows + 1
		  to: columnIndex * numberOfRows
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> columnAverage [
	
	| runningAverage |
	runningAverage := Array new: numberOfColumns.
	1 to: numberOfColumns do: [ :column |
		1 to: numberOfRows do: [ :row |
			runningAverage at: column put: (self atRow: row atColumn: column)
		]
	].
	1 to: numberOfColumns do: [ :column |
		runningAverage at: column put: (runningAverage at: column) / numberOfRows
	].
	^ runningAverage
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> contents [

	^ contents
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> contentsForLapack [

	^ contents asFFIExternalArrayOfType: 'double'
]

{ #category : #converting }
AINativeFloatContiguousColumnMajorMatrix >> flattened [

	"I'm already in a flattened representation"
	^ self
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> numberOfColumns: anObject [

	numberOfColumns := anObject
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix >> numberOfRows: anObject [

	numberOfRows := anObject
]

{ #category : #'point functions' }
AINativeFloatContiguousColumnMajorMatrix >> transposed [

	| newMatrix |
	newMatrix := self class new: self numberOfColumns.

	(1 to: self numberOfColumns) do: [ :j | 
		newMatrix at: j put: (Array new: self numberOfRows).

		(1 to: self numberOfRows) do: [ :i | 
			newMatrix at: j at: i put: (self at: i at: j) ] ].
	
	^ newMatrix
]
