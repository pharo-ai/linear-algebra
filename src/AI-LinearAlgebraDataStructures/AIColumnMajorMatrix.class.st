"
I am a matrix with an internal representation that is:
 - contiguous
 - column major
 - containing pharo floats

I am optimised to minimise data movement inside Pharo and avoid native<->pharo float marshallings.
My #contentsForLapack method transforms my contents to a native float array.

Internally, I use an Array.
"
Class {
	#name : #AIColumnMajorMatrix,
	#superclass : #AIContiguousMatrix,
	#type : #variable,
	#category : #'AI-LinearAlgebraDataStructures'
}

{ #category : #accessing }
AIColumnMajorMatrix class >> arrayKind [

	"The kind of array used by default for my internal representation"

	^ Array
]

{ #category : #accessing }
AIColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex [ 
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex
]

{ #category : #accessing }
AIColumnMajorMatrix >> atRow: rowIndex atColumn: columnIndex put: aValue [
	
	^ contents at: (columnIndex - 1 * numberOfRows) + rowIndex put: aValue
]

{ #category : #'linear algebra' }
AIColumnMajorMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Array new: numberOfColumns withAll: 0.0)
]

{ #category : #operating }
AIColumnMajorMatrix >> columnAverageIntoResultArray: resultArray [

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
AIColumnMajorMatrix >> contentsForLapack [

	"Take the pharo float array and transform it to a native float array"

	^ contents asFFIExternalArrayOfType: 'double'
]

{ #category : #'transforming - lapack' }
AIColumnMajorMatrix >> contentsForLapackOfAtLeast: size [

	"Take the pharo float array and transform it to a native float array"

	^ contents asFFIExternalArrayOfType: 'double' size: (contents size max: size)
]

{ #category : #'linear algebra' }
AIColumnMajorMatrix >> transposed [

	^ AIRowMajorMatrix values: contents rows: numberOfColumns columns: numberOfRows
]
