!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: 'aThreePerThreeBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'setUp' stamp: 'lm 5/15/2017 20:26:35'!
setUp

	aThreePerThreeBoard := Rectangle origin: 0@0 corner: 3@3.
	! !


!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:24:46'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife|
	
		
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:26:58'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife|
		
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:27:15'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:27:27'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:27:37'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife|
	
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'lm 5/15/2017 20:27:54'!
test06CreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withBoard: aThreePerThreeBoard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'public' stamp: 'lm 5/15/2017 20:13:12'!
nextGeneration
			
	"actualiza las celulas vivas en aliveCells"
	
	
	aliveCells :=  self selectFromAllCells: [ :aCell | 
		
		(self hasToSurvive: aCell) 
		or: [ self hasToResurrect: aCell] ].! !


!GameOfLife methodsFor: 'initialization' stamp: 'fz 5/15/2017 19:07:59'!
initializeWith: aCollectionOfAliveCells withBoard: aRectangle

	board := aRectangle.
	aliveCells := aCollectionOfAliveCells.! !


!GameOfLife methodsFor: 'testing' stamp: 'lm 5/15/2017 20:08:44'!
hasToResurrect: aCell

	^(self isDeadAt: aCell) and: [(self numberOfAliveNeighboursOf: aCell) = 3].! !

!GameOfLife methodsFor: 'testing' stamp: 'lm 5/15/2017 20:07:44'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^ (self isAlive: aCell) and: [numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]]! !

!GameOfLife methodsFor: 'testing' stamp: 'lm 5/15/2017 19:43:30'!
isAlive: aCell

	^(aliveCells includes: aCell) ! !

!GameOfLife methodsFor: 'testing' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'testing' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'private' stamp: 'lm 5/15/2017 20:02:37'!
selectFromAllCells: aCondition

	|cellsThatMeetCondition boardCornerLimit|

	cellsThatMeetCondition := OrderedCollection new.
	
		
	boardCornerLimit := board corner.
	
	0 to: boardCornerLimit x do: [ :x |
		0 to: boardCornerLimit y do: [ :y |
			(aCondition value: x@y) ifTrue: [ cellsThatMeetCondition add: x@y ] ] ]. 
	
	
	^ cellsThatMeetCondition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:13:26'!
withLiveCells: aCollectionOfAliveCells withBoard: aBoard
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | (aBoard containsPoint: aCell)]) ifFalse: [self error: 'celda fuera de rango'].
	
	^self new initializeWith: aCollectionOfAliveCells withBoard: aBoard.! !
