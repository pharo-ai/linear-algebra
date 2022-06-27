Class {
	#name : #AIPharoFloatContiguousColumnMajorMatrix,
	#superclass : #AIContiguousColumnMajorMatrix,
	#type : #variable,
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
		  newContents: (Array new: aNumberOfColumns * aNumberOfRows)
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

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Array new: numberOfColumns withAll: 0.0)
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> contentsForLapack [

	"Take the pharo float array and transform it to a native float array"
	^ contents asFFIExternalArrayOfType: 'double'
]
