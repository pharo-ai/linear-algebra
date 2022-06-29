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
	#name : #AIPharoFloatContiguousColumnMajorMatrix,
	#superclass : #AIContiguousColumnMajorMatrix,
	#type : #variable,
	#category : #'AI-LinearAlgebra'
}

{ #category : #accessing }
AIPharoFloatContiguousColumnMajorMatrix class >> arrayKind [
	"The kind of array used by default for my internal representation"
	^ Array
]

{ #category : #operating }
AIPharoFloatContiguousColumnMajorMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Array new: numberOfColumns withAll: 0.0)
]

{ #category : #converting }
AIPharoFloatContiguousColumnMajorMatrix >> contentsForLapackOfAtLeast: size [

	"Take the pharo float array and transform it to a native float array"
	^ contents asFFIExternalArrayOfType: 'double' size: (contents size max: size)
]

{ #category : #'private - accessing' }
AIPharoFloatContiguousColumnMajorMatrix >> defaultElement [
	
	"I'm made of normal arrays initialized in nil"
	^ nil
]
