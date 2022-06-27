Class {
	#name : #AINativeFloatContiguousColumnMajorMatrix,
	#superclass : #AIContiguousColumnMajorMatrix,
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
		  newContents: (Float64Array new: aNumberOfColumns * aNumberOfRows)
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
AINativeFloatContiguousColumnMajorMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Float64Array new: numberOfColumns)
]

{ #category : #'transforming - lapack' }
AINativeFloatContiguousColumnMajorMatrix >> contentsForLapack [

	^ contents
]
