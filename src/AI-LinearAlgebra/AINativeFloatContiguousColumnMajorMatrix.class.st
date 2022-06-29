"
I am a matrix with an internal representations that is:
 - contiguous
 - column major
 - containing native floats

I am optimised to minimise data movement.
My #contentsForLapack method returns just my contents without any manipulation.

Internally, I use a Float64Array.
"
Class {
	#name : #AINativeFloatContiguousColumnMajorMatrix,
	#superclass : #AIContiguousColumnMajorMatrix,
	#category : #'AI-LinearAlgebra'
}

{ #category : #accessing }
AINativeFloatContiguousColumnMajorMatrix class >> arrayKind [
	"The kind of array used by default for my internal representation"
	^ Float64Array
]

{ #category : #operating }
AINativeFloatContiguousColumnMajorMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Float64Array new: numberOfColumns)
]

{ #category : #'transforming - lapack' }
AINativeFloatContiguousColumnMajorMatrix >> contentsForLapackOfAtLeast: size [
	
	contents size < size
		ifTrue: [ self notYetImplemented ].
	^ self contentsForLapack
]

{ #category : #'private - accessing' }
AINativeFloatContiguousColumnMajorMatrix >> defaultElement [

	"I'm made of Float arrays initialized in 0.0"
	^ 0.0
]
