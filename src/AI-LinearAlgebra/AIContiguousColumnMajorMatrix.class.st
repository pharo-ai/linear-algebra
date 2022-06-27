Class {
	#name : #AIContiguousColumnMajorMatrix,
	#superclass : #AIAbstractMatrix,
	#instVars : [
		'numberOfRows',
		'numberOfColumns',
		'contents'
	],
	#category : #'AI-LinearAlgebra'
}

{ #category : #testing }
AIContiguousColumnMajorMatrix class >> isAbstract [

	^ self == AIContiguousColumnMajorMatrix
]

{ #category : #operating }
AIContiguousColumnMajorMatrix >> -= aCollection [ 
	
	"Assume a collection is a matrix of one row"
	1 to: numberOfRows do: [ :row |
		1 to: numberOfColumns do: [ :column | | me |
			me := self atRow: row atColumn: column.
			self atRow: row atColumn: column put: (me - (aCollection at: column))
		]
	]
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex put: aValue
]

{ #category : #operating }
AIContiguousColumnMajorMatrix >> columnAverageIntoResultArray: resultArray [

	1 to: numberOfColumns do: [ :column | 
		1 to: numberOfRows do: [ :row | 
			resultArray
				at: column
				put: (resultArray at: column) + (self atRow: row atColumn: column) ] ].
	1 to: numberOfColumns do: [ :column | 
		resultArray at: column put: (resultArray at: column) / numberOfRows ].
	^ resultArray
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> contents [

	^ contents
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> numberOfColumns: anObject [

	numberOfColumns := anObject
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
AIContiguousColumnMajorMatrix >> numberOfRows: anObject [

	numberOfRows := anObject
]
