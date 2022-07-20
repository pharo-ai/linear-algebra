"
I am the abstract superclass of matrixes represented as a contiguous array.
I implement the main accessing and manipulation methods.

See my superclass for more details
"
Class {
	#name : #AIContiguousMatrix,
	#superclass : #AIAbstractMatrix,
	#type : #variable,
	#instVars : [
		'numberOfRows',
		'numberOfColumns',
		'contents'
	],
	#category : #'AI-LinearAlgebraDataStructures'
}

{ #category : #accessing }
AIContiguousMatrix class >> arrayKind [

	"The kind of array used by default for my internal representation"

	self subclassResponsibility
]

{ #category : #testing }
AIContiguousMatrix class >> isAbstract [

	^ self == AIContiguousMatrix
]

{ #category : #'instance creation' }
AIContiguousMatrix class >> newContents: flattenedMatrix rows: numberOfRows columns: numberOfColumns [

	^ self new
		contents: (flattenedMatrix first: numberOfRows * numberOfColumns);
		numberOfRows: numberOfRows;
		numberOfColumns: numberOfColumns;
		yourself
]

{ #category : #'instance creation' }
AIContiguousMatrix class >> newRows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		newContents: (self arrayKind new: aNumberOfColumns * aNumberOfRows)
		rows: aNumberOfRows
		columns: aNumberOfColumns
]

{ #category : #'instance creation' }
AIContiguousMatrix class >> values: flattenedMatrix rows: aNumberOfRows columns: aNumberOfColumns [

	^ self
		newContents: flattenedMatrix
		rows: aNumberOfRows
		columns: aNumberOfColumns
]

{ #category : #operating }
AIContiguousMatrix >> -= aCollection [ 
	
	"Assume a collection is a matrix of one row"
	1 to: numberOfRows do: [ :row |
		1 to: numberOfColumns do: [ :column | | me |
			me := self atRow: row atColumn: column.
			self atRow: row atColumn: column put: (me - (aCollection at: column))
		]
	]
]

{ #category : #comparing }
AIContiguousMatrix >> = aMatrix [

	self class = aMatrix class ifFalse: [ ^ false ].
	^ contents = aMatrix contents
		and: [ numberOfRows = aMatrix numberOfRows
			and: [ numberOfColumns = aMatrix numberOfColumns ] ]
		
]

{ #category : #accessing }
AIContiguousMatrix >> atRow: row [

	"Returns the row"

	^ (1 to: numberOfColumns) collect: [ :column | self atRow: row atColumn: column ]
]

{ #category : #'accessing - private' }
AIContiguousMatrix >> contents [

	^ contents
]

{ #category : #'accessing - private' }
AIContiguousMatrix >> contents: anObject [

	contents := anObject
]

{ #category : #'transforming - lapack' }
AIContiguousMatrix >> contentsForLapack [

	^ self subclassResponsibility
]

{ #category : #'transforming - lapack' }
AIContiguousMatrix >> contentsForLapackOfAtLeast: size [

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
AIContiguousMatrix >> defaultElement [

	"I'm made of normal arrays initialized in nil"

	^ nil
]

{ #category : #comparing }
AIContiguousMatrix >> hash [

	^ contents hash bitXor: (numberOfRows hash bitXor: numberOfColumns hash)
]

{ #category : #inspector }
AIContiguousMatrix >> inspectorExtension [

	<inspectorPresentationOrder: 0 title: 'Matrix'>
	
	| specTable |
	specTable := SpTablePresenter new.
	specTable addColumn: (SpIndexTableColumn new
		title: '#';
		width: 30;
		yourself).

	1 to: numberOfColumns do: [ :index | 
		specTable addColumn: (SpStringTableColumn new
			title: index asString;
			evaluated: [ :each | each at: index ];
			yourself) ].
	
	specTable items: ((1 to: numberOfRows) collect: [ :index | self atRow: index ]).
	
	^ specTable 
]

{ #category : #accessing }
AIContiguousMatrix >> numberOfColumns [

	^ numberOfColumns
]

{ #category : #accessing }
AIContiguousMatrix >> numberOfColumns: anObject [

	numberOfColumns := anObject
]

{ #category : #accessing }
AIContiguousMatrix >> numberOfRows [

	^ numberOfRows
]

{ #category : #accessing }
AIContiguousMatrix >> numberOfRows: anObject [

	numberOfRows := anObject
]
