!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 18:57:57'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife board|
	
	board := Rectangle origin: 0@0 corner: 3@3.
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withBoard: board.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 18:58:36'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife board|
	
	board := Rectangle origin: 0@0 corner: 3@3.
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withBoard: board.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 18:59:17'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife board|
	
	board := Rectangle origin: 0@0 corner: 3@3.
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withBoard: board.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 18:59:42'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife board|
	
	board := Rectangle origin: 0@0 corner: 3@3.
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withBoard: board.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:00:07'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife board|
	
	board := Rectangle origin: 0@0 corner: 3@3.
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withBoard: board.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:00:47'!
test06CreateCellOutsideBounds

	|board|
	
	board := Rectangle origin: 0@0 corner: 3@3.

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withBoard: board ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:22:47'!
deadCells
	
	| deadCells|
	
	deadCells _ OrderedCollection new.
	
	self forAllCellsDo: [:aCell | (self isDeadAt: aCell) ifTrue: [deadCells add: aCell]].
	
	^deadCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:20:49'!
forAllCellsDo: anAction
	
	| boardCornerLimit|
	
	boardCornerLimit := board corner.
	
	0 to: boardCornerLimit x do: [ :x |
		0 to: boardCornerLimit y do: [ :y |
			anAction value: x@y]]. ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/9/2017 20:53:16'!
initializeWith: aCollectionOfAliveCells 

	aliveCells := aCollectionOfAliveCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:07:59'!
initializeWith: aCollectionOfAliveCells withBoard: aRectangle

	board := aRectangle.
	aliveCells := aCollectionOfAliveCells.! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:29:13'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union:
		(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'fz 5/15/2017 19:13:26'!
withLiveCells: aCollectionOfAliveCells withBoard: aBoard
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | (aBoard containsPoint: aCell)]) ifFalse: [self error: 'celda fuera de rango'].
	
	^self new initializeWith: aCollectionOfAliveCells withBoard: aBoard.! !
