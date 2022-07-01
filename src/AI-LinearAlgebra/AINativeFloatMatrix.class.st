"
I am a matrix with an internal representations that is:
 - contiguous
 - column major
 - containing native floats

I store my elements in machine code float numbers. Look my class side method `arrayType`.
I am good to use for make FFI calls. Because there is no need to convert the methods from the pharo float objects to machine floats. But, is you use me in Pharo for making, for example, sum of multiplications I will be slow because I need to convert from machine floats to Pharo floats. For that, better use AIColumnMajorMatrix.

My #contentsForLapack method returns just my contents without any manipulation.

Internally, I use a Float64Array.
"
Class {
	#name : #AINativeFloatMatrix,
	#superclass : #AIColumnMajorMatrix,
	#type : #variable,
	#category : #'AI-LinearAlgebra'
}

{ #category : #accessing }
AINativeFloatMatrix class >> arrayKind [
	"The kind of array used by default for my internal representation"
	^ Float64Array
]

{ #category : #'linear algebra' }
AINativeFloatMatrix >> columnAverage [
	
	^ self columnAverageIntoResultArray: (Float64Array new: numberOfColumns)
]

{ #category : #'transforming - lapack' }
AINativeFloatMatrix >> contentsForLapack [

	^ contents
]

{ #category : #'transforming - lapack' }
AINativeFloatMatrix >> contentsForLapackOfAtLeast: size [

	contents size < size ifTrue: [ self notYetImplemented ].
	^ self contentsForLapack
]

{ #category : #'private - accessing' }
AINativeFloatMatrix >> defaultElement [

	"I'm made of Float arrays initialized in 0.0"
	^ 0.0
]
