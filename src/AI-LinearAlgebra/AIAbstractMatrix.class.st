"
I define the basic API of matrixes for Pharo-AI projects.
My concrete subclasses should implement mainly the methods:
 - #-= aRow => substracts in place the row as argument to each of the rows in the matrix
 - #columnAverage => returns a row with the averages of each column
 - #contentsForLapack => returns the matrix in lapack's representation (contiguous column-major native float array)
"
Class {
	#name : #AIAbstractMatrix,
	#superclass : #Object,
	#category : #'AI-LinearAlgebra'
}

{ #category : #testing }
AIAbstractMatrix class >> isAbstract [

	^ self == AIAbstractMatrix
]

{ #category : #'instance creation' }
AIAbstractMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	self subclassResponsibility
]

{ #category : #'instance creation' }
AIAbstractMatrix class >> rows: rowMajorNonFlattenedMatrix [

	^ (self
		   newRows: rowMajorNonFlattenedMatrix size
		   columns: rowMajorNonFlattenedMatrix first size)
		  initializeRows: rowMajorNonFlattenedMatrix;
		  yourself
]

{ #category : #'instance creation' }
AIAbstractMatrix class >> values: rowMajorNonFlattenedMatrix rows: aNumberOfRows columns: aNumberOfColumns [

	| rows index |
	rows := (1 to: aNumberOfRows) collect: [ :i | 
		        (1 to: aNumberOfColumns) collect: [ :j | 
			        index := (i - 1) * aNumberOfColumns + j.
			        rowMajorNonFlattenedMatrix at: index ] ].

	^ (self newRows: aNumberOfRows columns: aNumberOfColumns)
		  initializeRows: rows;
		  yourself
]

{ #category : #operating }
AIAbstractMatrix >> -= aCollection [ 
	
	self subclassResponsibility
]

{ #category : #accessing }
AIAbstractMatrix >> atRow: rowIndex atColumn: columnIndex [

	self subclassResponsibility
]

{ #category : #accessing }
AIAbstractMatrix >> atRow: rowIndex atColumn: columnIndex put: value [

	self subclassResponsibility
]

{ #category : #operating }
AIAbstractMatrix >> columnAverage [

	self subclassResponsibility
]

{ #category : #initialization }
AIAbstractMatrix >> initializeRows: aCollectionOfCollections [

	aCollectionOfCollections withIndexCollect: [ :row :rowIndex | 
		row withIndexCollect: [ :value :columnIndex | 
			self atRow: rowIndex atColumn: columnIndex put: value ] ]
]

{ #category : #'linear algebra' }
AIAbstractMatrix >> transposed [

	^ self subclassResponsibility
]
