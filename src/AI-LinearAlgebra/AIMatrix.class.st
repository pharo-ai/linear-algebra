"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #AIMatrix,
	#superclass : #Object,
	#category : #'AI-LinearAlgebra-Matrix'
}

{ #category : #accessing }
AIMatrix class >> browserIcon [
"Answer icon to be displayed with matrix classes."
	
	^ nil
]

{ #category : #'instance creation' }
AIMatrix class >> new [
	"Create a new matrix with dimension zero."
	
	^self new: Number zero
]

{ #category : #'instance creation' }
AIMatrix class >> new: numberOrPoint [
	"Create a new square matrix with the given dimension."
	
	| point |
	point := numberOrPoint asPoint.
	^self
		rows: point x
		columns: point y
]

{ #category : #'instance creation' }
AIMatrix class >> new: numberOrPoint withAll: value [
	
	^(self new: numberOrPoint)
		atAllPut: value;
		yourself
]

{ #category : #'instance creation' }
AIMatrix class >> readFromDenseText: aStream [
	| m n matrix |
	m := Integer readFrom: aStream skipSeparators.
	n := Integer readFrom: aStream skipSeparators.
	matrix := self rows: m columns: n.
	1 to: m do: [ :row | 1 to: n do: [ :column | matrix at: row and: column put: (Number readFrom: aStream skipSeparators) ] ].
	^ matrix
]

{ #category : #'instance creation' }
AIMatrix class >> readFromSparseText: aStream [
	
	| m n matrix |
	n := Integer readFrom: aStream skipSeparators.
	m := Integer readFrom: aStream skipSeparators.
	Integer readFrom: aStream skipSeparators.
	matrix := self
		rows: m
		columns: n
		withAll: Number zero.
	1
		to: m
		do:
			[:rows | 
			1
				to: (Integer readFrom: aStream skipSeparators)
				do:
					[:unused | 
					matrix
						at: rows
						and: (Integer readFrom: aStream skipSeparators) + 1
						put: (Number readFrom: aStream skipSeparators)]].
	^matrix
]

{ #category : #'instance creation' }
AIMatrix class >> rows: m columns: n [
	"Create a new matrix with m rows and n columns."
	
	^(self basicNew)
		initializeRows: m columns: n;
		yourself
]

{ #category : #'instance creation' }
AIMatrix class >> rows: m columns: n withAll: value [
	
	^(self rows: m columns: n)
		atAllPut: value;
		yourself
]

{ #category : #private }
AIMatrix class >> switch: anObject caseMatrix: matrixBlock caseNestedCollection: nestedColletionBlock caseCollection: collectionBlock default: defaultBlock [
	(anObject isKindOf: AIMatrix) ifTrue: [ ^ matrixBlock value ].
	
	anObject isCollection
		ifTrue: [ (anObject isNotEmpty and: [ anObject allSatisfy: [ :each | each isCollection and: [ each size = anObject first size ] ] ])
				ifTrue: [ ^ nestedColletionBlock value ]
				ifFalse: [ ^ collectionBlock value ] ].
	^ defaultBlock value
]

{ #category : #'constants access' }
AIMatrix class >> unity [
	
	^AIMatrixCoercion with: 1
]

{ #category : #private }
AIMatrix class >> vectorSpecies [
	
	^AIArrayVector
]

{ #category : #'instance creation' }
AIMatrix class >> withAll: object [
	
	| dimension |
	dimension := self
		switch: object
		caseMatrix: [object dimension]
		caseNestedCollection: [object size @ object first size]
		caseCollection: [1 @ object size]
		default: [0].
	^(self new: dimension)
		atAllPut: object;
		yourself
]

{ #category : #'constants access' }
AIMatrix class >> zero [
	
	^AIMatrixCoercion with: 0
]

{ #category : #arithmetic }
AIMatrix >> * aNumber [
	
	^aNumber productFromMatrix: self
]

{ #category : #arithmetic }
AIMatrix >> *= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a * b]
]

{ #category : #'matrix functions' }
AIMatrix >> *~ aMatrix [
	"Answer the matrix multiplication of the reciever with the argument."
	
	| newMatrix |
	self columnSize = aMatrix rowSize ifFalse: [Array new noMatchError].
	newMatrix := self species
		rows: self rowSize
		columns: aMatrix columnSize.	"workaround: this should be done in a more generic way with double dispatch."
	newMatrix
		putWithIndices:
			((aMatrix isKindOf: AIDiagonalMatrix)
				ifTrue: [[:i :j | (self at: i and: j) * (aMatrix at: j and: j)]]
				ifFalse:
					[[:i :j | 
					(1 to: self columnSize)
						inject: 0
						into:
							[:sum :k | sum + ((self at: i and: k) * (aMatrix at: k and: j))]]]).
	^newMatrix
]

{ #category : #arithmetic }
AIMatrix >> + aNumber [
	
	^aNumber sumFromMatrix: self
]

{ #category : #arithmetic }
AIMatrix >> += aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a + b]
]

{ #category : #arithmetic }
AIMatrix >> - aNumber [
	
	^aNumber differenceFromMatrix: self
]

{ #category : #arithmetic }
AIMatrix >> -= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a - b]
]

{ #category : #arithmetic }
AIMatrix >> / aNumber [
	
	^aNumber quotientFromMatrix: self
]

{ #category : #arithmetic }
AIMatrix >> /= aNumber [
	
	^self
		with: (self coerce: aNumber)
		affect: [:a :b | a / b]
]

{ #category : #comparing }
AIMatrix >> = matrix [
	"Answer whether the dimension of the receiver is the same as otherMatrix' dimension,
	and each of the receiver's elements equal the corresponding element of otherMatrix."
	
	^self == matrix
		or:
			[(matrix isKindOf: AIMatrix)
				and:
					[(matrix hasDimension: self dimension)
						and:
							[self
								with: matrix
								do: [:a :b | a = b ifFalse: [^false]].
							true]]]
]

{ #category : #arithmetic }
AIMatrix >> adaptToNumber: rcvr andSend: selector [

	^ self perform: selector with: rcvr
]

{ #category : #arithmetic }
AIMatrix >> adaptToPoint: rcvr andSend: selector [

	^ self perform: selector with: rcvr
]

{ #category : #resizing }
AIMatrix >> addColumn [
	"Add a column. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
AIMatrix >> addColumnBeforeIndex: anIndex [
	"Insert a column before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
AIMatrix >> addRow [
	"Add a row. Must implement if isExtendable returns true."
	
	self shouldNotImplement
]

{ #category : #resizing }
AIMatrix >> addRowBeforeIndex: anIndex [
	"Insert a row before anIndex. Must implement if isResizebale returns true."
	
	self shouldNotImplement
]

{ #category : #converting }
AIMatrix >> asArray [
	
	| array stream |
	array := Array new: self rowSize * self columnSize.
	stream := WriteStream on: array.
	self do: [:each | stream nextPut: each].
	^array
]

{ #category : #printing }
AIMatrix >> asDenseString [
	" Answer a <String> complete (or dense) representation of the receiver "

	^ (String streamContents: [ : stream | 
		self storeDenseTextOn: stream ]) 
			allButFirst: 4.
]

{ #category : #accessing }
AIMatrix >> at: row and: column [
	"Answer the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
AIMatrix >> at: row and: column add: aNumber [
	"Add aNumber to the element at row and column.  Answer the sum."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) + aNumber
]

{ #category : #arithmetic }
AIMatrix >> at: row and: column divide: aNumber [
	"Divide the element at row and column by aNumber.  Answer the quotient."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) / aNumber
]

{ #category : #arithmetic }
AIMatrix >> at: row and: column multiply: aNumber [
	"Multiply aNumber with the element at row and column.  Answer the product."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) * aNumber
]

{ #category : #accessing }
AIMatrix >> at: row and: column put: aNumber [
	"Store the vakue at the given indices."
	
	^self subclassResponsibility
]

{ #category : #arithmetic }
AIMatrix >> at: row and: column subtract: aNumber [
	"Subtract aNumber from the element at row and column.  Answer the difference."
	
	^self
		at: row
		and: column
		put: (self at: row and: column) - aNumber
]

{ #category : #accessing }
AIMatrix >> atAllPut: object [
	
	self class
		switch: object
		caseMatrix:
			[self
				with: object
				affect: [:a :b | b]]
		caseNestedCollection:
			[object size = self rowSize
				ifTrue:
					[[object first size = self columnSize] assert.
					self putWithIndices: [:row :column | (object at: row) at: column]]
				ifFalse:
					[object size = self columnSize
						ifTrue:
							[[object first size = self rowSize] assert.
							self putWithIndices: [:row :column | (object at: column) at: row]]
						ifFalse: [self error]]]
		caseCollection:
			[| stream |
			[object size = (self rowSize * self columnSize)] assert.
			stream := ReadStream on: object.
			self
				withIndices:
					[:row :column | 
					self
						at: row
						and: column
						put: stream next]]
		default:
			[self withIndices: [:row :column | self at: row and: column put: object]].
	^object
]

{ #category : #accessing }
AIMatrix >> atPoint: rowColumnCoordinate [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
]

{ #category : #accessing }
AIMatrix >> atPoint: rowColumnCoordinate put: aNumber [
	
	^self
		at: rowColumnCoordinate x
		and: rowColumnCoordinate y
		put: aNumber
]

{ #category : #private }
AIMatrix >> checkInvariant [
	
	^self subclassResponsibility
]

{ #category : #coercing }
AIMatrix >> coerce: aNumber [
	
	^AIMatrixCoercion with: aNumber
]

{ #category : #enumerating }
AIMatrix >> collect: aBlock [
	
	| newMatrix |
	newMatrix := self copyEmpty.
	self
		withIndices:
			[:row :column | 
			newMatrix
				at: row
				and: column
				put: (aBlock value: (self at: row and: column))].
	^newMatrix
]

{ #category : #'accessing vectorwise' }
AIMatrix >> columnAt: columnIndex [
	
	^AIMatrixPath column: columnIndex on: self
]

{ #category : #'accessing vectorwise' }
AIMatrix >> columnAt: columnIndex put: vector [
	
	vector doWithIndex: [:each :row | self at: row and: columnIndex put: each].
	^vector
]

{ #category : #accessing }
AIMatrix >> columnSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
AIMatrix >> columns [
	
	| array |
	array := Array new: self columnSize.
	1
		to: self columnSize
		do:
			[:index | 
			array
				at: index
				put: (self columnAt: index)].
	^array
]

{ #category : #copying }
AIMatrix >> copyEmpty [
	"Answer a copy of the receiver that contains no elements."
	
	^self copyEmpty: self dimension
]

{ #category : #copying }
AIMatrix >> copyEmpty: dimension [
	"Answer a copy of the receiver that contains no elements."
	
	^self species new: dimension
]

{ #category : #copying }
AIMatrix >> deepCopy [
	
	^self species withAll: self
]

{ #category : #accessing }
AIMatrix >> density [
	
	^self sparseSize / self size
]

{ #category : #arithmetic }
AIMatrix >> determinant [
	
	| a11 a12 a21 a22 |
	[self hasDimension: 2 @ 2] assert.
	a11 := self atPoint: 1 @ 1.
	a12 := self atPoint: 1 @ 2.
	a21 := self atPoint: 2 @ 1.
	a22 := self atPoint: 2 @ 2.
	^a11 * a22 - (a12 * a21)
]

{ #category : #'accessing vectorwise' }
AIMatrix >> diagonal [
	
	^AIMatrixPath diagonalOn: self
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromFixedPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromFloat: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromFraction: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromInteger: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a - b]
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromNumber: aNumber [
	
	^self collect: [:b | aNumber - b]
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromPoint: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> differenceFromSmallDouble: aNumber [
	
	^self differenceFromNumber: aNumber
]

{ #category : #accessing }
AIMatrix >> dimension [
	
	^self rowSize @ self columnSize
]

{ #category : #enumerating }
AIMatrix >> do: aBlock [
	
	self
		withIndices: [:row :column | aBlock value: (self at: row and: column)].
	^self
]

{ #category : #enumerating }
AIMatrix >> doSparseWithIndices: eachRowColumnBlock [
	
	self
		doWithIndices:
			[:each :row :column | 
			each isZero
				ifFalse: [eachRowColumnBlock value: each value: row value: column]].
	^self
]

{ #category : #enumerating }
AIMatrix >> doWithIndices: eachRowColumnBlock [
	
	self
		withIndices:
			[:row :column | 
			eachRowColumnBlock
				value: (self at: row and: column)
				value: row
				value: column]
]

{ #category : #accessing }
AIMatrix >> first [
	
	^self at: 1 and: 1
]

{ #category : #coercing }
AIMatrix >> generality [
	
	^240
]

{ #category : #testing }
AIMatrix >> hasDimension: aDimension [
	
	^self dimension = aDimension
]

{ #category : #comparing }
AIMatrix >> hash [
	
	^(self dimension hash bitXor: (self at: 1) hash)
		bitXor: (self at: self dimension) hash
]

{ #category : #'initialize-release' }
AIMatrix >> initializeRows: m columns: n [
	
	^self subclassResponsibility
]

{ #category : #enumerating }
AIMatrix >> inject: value into: aBlock [
	
	| result |
	result := value.
	self do: [:each | result := aBlock value: result value: each].
	^result
]

{ #category : #testing }
AIMatrix >> isComplex [
	
	^false
]

{ #category : #testing }
AIMatrix >> isDiagonal [
	"Answer if the reciever is a diagonal matrix."
	
	self isSquare ifFalse: [^false].
	self
		doSparseWithIndices:
			[:value :row :column | row = column ifFalse: [^false]].
	^true
]

{ #category : #testing }
AIMatrix >> isResizeable [
	
	^false
]

{ #category : #testing }
AIMatrix >> isSquare [
	"Answer if the reciever is a square matrix."
	
	^self rowSize = self columnSize
]

{ #category : #testing }
AIMatrix >> isSymetric [
	"Answer if the reciever is a symetric matrix."
	
	self isSquare ifFalse: [^false].
	1
		to: self columnSize
		do:
			[:column | 
			1
				to: column
				do:
					[:row | (self at: column and: row) = (self at: row and: column) ifFalse: [^false]]].
	^true
]

{ #category : #testing }
AIMatrix >> isZero [
	"Answer if the reciever contains no non-zero numbers."
	
	self doSparseWithIndices: [:value :row :column | ^false].
	^true
]

{ #category : #testing }
AIMatrix >> isZeroAt: row and: column [
	
	^(self at: row and: column) isZero
]

{ #category : #accessing }
AIMatrix >> last [
	
	^self
		at: self rowSize
		and: self columnSize
]

{ #category : #private }
AIMatrix >> noMatchError [
	self error: 'No match'
]

{ #category : #private }
AIMatrix >> noModificationError [
	self error: 'No modification'
]

{ #category : #printing }
AIMatrix >> printOn: aStream [
	"Append to the argument aStream a sequence of characters that identifies the matrix."

	| tooMany |
	tooMany := aStream position + 5000.
	aStream
		print: self class;
		space;
		print: self dimension;
		space;
		nextPut: $(.
	(1 to: self rowSize)
		do: [ :row | 
			aStream nextPut: $(.
			(1 to: self columnSize)
				do: [ :column | 
					aStream position > tooMany
						ifTrue: [ aStream
								nextPutAll: '...etc...';
								nextPutAll: '))'.
							^ self ].
					aStream print: (self at: row and: column) ]
				separatedBy: [ aStream space ].
			aStream nextPut: $) ]
		separatedBy: [ aStream space ].
	aStream nextPut: $)
]

{ #category : #'double dispatching' }
AIMatrix >> productFromDiagonalMatrix: aDiagonalMatrix [
	
	  1 to: aDiagonalMatrix rowSize do: [:i|
		aDiagonalMatrix at: i and: i put: (aDiagonalMatrix at:i and: i)*(self at: i and: i ) ].

	  ^aDiagonalMatrix 
]

{ #category : #'double dispatching' }
AIMatrix >> productFromDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromFixedPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromFloat: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromFraction: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromInteger: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a * b]
]

{ #category : #'double dispatching' }
AIMatrix >> productFromNumber: aNumber [
	
	^self collect: [:b | aNumber * b]
]

{ #category : #'double dispatching' }
AIMatrix >> productFromPoint: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> productFromSmallDouble: aNumber [
	
	^self productFromNumber: aNumber
]

{ #category : #enumerating }
AIMatrix >> putWithIndices: rowColumnBlock [
	
	self
		withIndices:
			[:row :column | 
			self
				at: row
				and: column
				put: (rowColumnBlock value: row value: column)].
	^self
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromFixedPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromFloat: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromFraction: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromInteger: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a / b]
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromNumber: aNumber [
	
	^self collect: [:b | aNumber / b]
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromPoint: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> quotientFromSmallDouble: aNumber [
	
	^self quotientFromNumber: aNumber
]

{ #category : #arithmetic }
AIMatrix >> reciprocal [
	
	^self
		collect:
			[:each | 
			each isZero
				ifTrue: [each]
				ifFalse: [each reciprocal]]
]

{ #category : #converting }
AIMatrix >> remap: mapping [
	
	^AIMappedMatrix on: self rowMap: mapping columnMap: mapping
]

{ #category : #resizing }
AIMatrix >> removeColumnAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #resizing }
AIMatrix >> removeRowAtIndex: anIndex [
	
	self shouldNotImplement
]

{ #category : #testing }
AIMatrix >> respondsToArithmetic [
	"We are arithmetic, yes."
	
	^true
]

{ #category : #arithmetic }
AIMatrix >> roundTo: aNumber [
	
	^self collect: [:each | each roundTo: aNumber]
]

{ #category : #'accessing vectorwise' }
AIMatrix >> rowAt: rowIndex [
	
	^AIMatrixPath row: rowIndex on: self
]

{ #category : #'accessing vectorwise' }
AIMatrix >> rowAt: rowIndex put: vector [
	
	vector
		doWithIndex: [:each :column | self at: rowIndex and: column put: each].
	^vector
]

{ #category : #accessing }
AIMatrix >> rowSize [
	
	^self subclassResponsibility
]

{ #category : #'accessing vectorwise' }
AIMatrix >> rows [
	
	| array |
	array := Array new: self rowSize.
	1
		to: self rowSize
		do:
			[:index | 
			array
				at: index
				put: (self rowAt: index)].
	^array
]

{ #category : #accessing }
AIMatrix >> size [
	
	^self rowSize * self columnSize
]

{ #category : #accessing }
AIMatrix >> sparseSize [
	
	| tally |
	tally := 0.
	self do: [:each | each isZero ifTrue: [tally := tally + 1]].
	^tally
]

{ #category : #private }
AIMatrix >> species [
	
	^self class
]

{ #category : #printing }
AIMatrix >> storeDenseTextOn: aStream [
	"Append to the argument aStream a sequence of characters 
	that identifies the collection."
	
	aStream
		print: self rowSize;
		space;
		print: self columnSize;
		cr.
	1
		to: self rowSize
		do:
			[:row | 
			(1 to: self columnSize)
				do: [:column | aStream print: (self at: row and: column)]
				separatedBy: [aStream space].
			aStream cr]
]

{ #category : #printing }
AIMatrix >> storeSparseTextOn: aStream [
	"Append to the argument aStream a sequence of characters 
	that identifies the collection."
	
	aStream
		print: self columnSize;
		space;
		print: self rowSize;
		space;
		print: self sparseSize;
		cr.
	self rows
		do:
			[:row | 
			aStream
				print: row sparseSize;
				cr.
			row
				doSparseWithIndex:
					[:value :index | 
					aStream
						print: index - 1;
						space;
						print: value;
						cr]]
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromFixedPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromFloat: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromFraction: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromInteger: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromMatrix: aMatrix [
	
	^aMatrix
		with: self
		collect: [:a :b | a + b]
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromNumber: aNumber [
	
	^self collect: [:b | aNumber + b]
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromPoint: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'double dispatching' }
AIMatrix >> sumFromSmallDouble: aNumber [
	
	^self sumFromNumber: aNumber
]

{ #category : #'matrix functions' }
AIMatrix >> transposed [
	
	^AIMatrixView transposeOn: self
]

{ #category : #private }
AIMatrix >> vectorSpecies [
	
	^self class vectorSpecies
]

{ #category : #enumerating }
AIMatrix >> with: aMatrix affect: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		putWithIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
AIMatrix >> with: aMatrix collect: eachOtherBlock [
	
	| newMatrix |
	[aMatrix hasDimension: self dimension] assert.
	newMatrix := self copyEmpty: self dimension.
	newMatrix
		putWithIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)].
	^newMatrix
]

{ #category : #enumerating }
AIMatrix >> with: aMatrix do: eachOtherBlock [
	
	[aMatrix hasDimension: self dimension] assert.
	self
		withIndices:
			[:row :column | 
			eachOtherBlock
				value: (self at: row and: column)
				value: (aMatrix at: row and: column)]
]

{ #category : #enumerating }
AIMatrix >> withIndices: aBlock [
	
	1
		to: self rowSize
		do:
			[:row | 
			1
				to: self columnSize
				do: [:column | aBlock value: row value: column]]
]
