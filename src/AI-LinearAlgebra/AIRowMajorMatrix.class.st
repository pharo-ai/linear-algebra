"
As my brother, am a matrix with an internal representation that is:
 - contiguous
 - column major
 - containing pharo floats

The difference is that I store the elements in a row major form, instead of a column major form
"
Class {
	#name : #AIRowMajorMatrix,
	#superclass : #AIContiguousMatrix,
	#type : #variable,
	#category : #'AI-LinearAlgebra'
}

{ #category : #accessing }
AIRowMajorMatrix class >> arrayKind [

	^ Array
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex [

	^ contents at: rowIndex - 1 * numberOfColumns + columnIndex
]

{ #category : #accessing }
AIRowMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (rowIndex - 1 * numberOfColumns + columnIndex) put: aValue
]

{ #category : #'linear algebra' }
AIRowMajorMatrix >> columnAverage [
	
	| resultArray |
	resultArray := Array new: numberOfColumns withAll: 0.0.
	
	1 to: numberOfColumns do: [ :column | 
		1 to: numberOfRows do: [ :row | 
			resultArray
				at: column
				put: (resultArray at: column) + (self atRow: row atColumn: column) ] ].
		
	1 to: numberOfColumns do: [ :column | 
		resultArray at: column put: (resultArray at: column) / numberOfRows ].
	^ resultArray
]

{ #category : #'transforming - lapack' }
AIRowMajorMatrix >> contentsForLapack [
	
	Exception signal: 'For calling LAPACK you need to use AIColumnMajorMatrix instead'
]

{ #category : #'transforming - lapack' }
AIRowMajorMatrix >> contentsForLapackOfAtLeast: size [

	Exception signal: 'For calling LAPACK you need to use AIColumnMajorMatrix instead'
]

{ #category : #'linear algebra' }
AIRowMajorMatrix >> transposed [

	^ AIColumnMajorMatrix values: contents rows: numberOfColumns columns: numberOfRows
]
