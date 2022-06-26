Class {
	#name : #AIPharoFloatContiguousColumnMajorMatrix,
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
AIPharoFloatContiguousColumnMajorMatrix class >> newContents: contents rows: aNumberOfRows columns: aNumberOfColumns [

	^ self new
		contents: contents;
		numberOfRows: aNumberOfRows;
		numberOfColumns: aNumberOfColumns;
		yourself
]

{ #category : #'as yet unclassified' }
AIPharoFloatContiguousColumnMajorMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: (Float64Array new: aNumberOfColumns * aNumberOfRows)
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #'as yet unclassified' }
AIPharoFloatContiguousColumnMajorMatrix class >> values: flattenedCollection rows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		  newContents: flattenedCollection
		  rows: aNumberOfRows
		  columns: aNumberOfColumns
]

{ #category : #operating }
AIPharoFloatContiguousColumnMajorMatrix >> -= aCollection [ 
	
	"Assume a collection is a matrix of one row"
	1 to: numberOfRows do: [ :row |
		1 to: numberOfColumns do: [ :column | | me |
			me := self atRow: row atColumn: column.
			self atRow: row atColumn: column put: (me - (aCollection at: column))
		]
	]
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> asArray [
	
	^ contents
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> asColumnMajor [

	^ self
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> asRowMajor [

	^ self notYetImplemented
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex put: aValue
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> columnAt: columnIndex [

	"A column runs from (c-1*n)+1 to c*n"

	^ contents
		  copyFrom: columnIndex - 1 * numberOfRows + 1
		  to: columnIndex * numberOfRows
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> columnAverage [
	
	| runningAverage |
	runningAverage := Float64Array new: numberOfColumns.
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
AIPharoFloatContiguousColumnMajorMatrix >> contents [

	^ contents
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> contents: anObject [

	contents := anObject
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> contentsForLapack [

	^ contents
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> flattened [

	"I'm already in a flattened representation"
	^ self
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> numberOfColumns: anObject [

	numberOfColumns := anObject
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> numberOfRows: anObject [

	numberOfRows := anObject
]

{ #category : #'point functions' }
AIPharoFloatContiguousColumnMajorMatrix >> transposed [

	| newMatrix |
	newMatrix := self class new: self numberOfColumns.

	(1 to: self numberOfColumns) do: [ :j | 
		newMatrix at: j put: (Array new: self numberOfRows).

		(1 to: self numberOfRows) do: [ :i | 
			newMatrix at: j at: i put: (self at: i at: j) ] ].
	
	^ newMatrix
]
