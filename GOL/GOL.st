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


!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:21:53'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife|
	
		
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:21:59'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife|
		
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:03'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:09'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife|
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife|
	
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 15:38:42'!
test06CanNotCreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withBoard: aThreePerThreeBoard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife outOfBoundsMessage]! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 15:40:02'!
test07CanNotCreateGameOfLifeWithNoAliveCells

	self 
		should: [ GameOfLife withLiveCells: {} withBoard: aThreePerThreeBoard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: GameOfLife noAliveCellsAtStartMessage]! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:18'!
test08DuplicatedAliveCellsPassedAtStartAreTakenAsOne

	|gameOfLife|	
	
	gameOfLife := GameOfLife withLiveCells: { 1@0. 1@0. 1@0 } withBoard: aThreePerThreeBoard.
	
	self assert: ((gameOfLife numberOfAliveNeighboursOf: 1@1) = 1 and:[gameOfLife isAlive:1@0] and:[gameOfLife isDead: 1@1]).! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:23'!
test09DeadCellWithLessThanThreeAliveNeighRemainsDead
	"este test pasó de una porque se debería haber hecho antes, para cuando lo agregamos ya se había implementado la solución, lo agregamos por una cuestión de completitud pero no sería la forma correcta de hacer TDD"
	|gameOfLife|
	
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. } withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDead: 1@1) ! !

!GOLTest methodsFor: 'tests' stamp: 'fz 5/16/2017 16:22:29'!
test10DeadCellWithMoreThanThreeAliveNeighRemainsDead
	"este test pasó de una porque se debería haber hecho antes, para cuando lo agregamos ya se había implementado la solución, lo agregamos por una cuestión de completitud pero no sería la forma correcta de hacer TDD"
	|gameOfLife|
	
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0. 2@2} withBoard: aThreePerThreeBoard.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDead: 1@1) ! !


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


!GameOfLife methodsFor: 'testing' stamp: 'fz 5/16/2017 16:22:37'!
hasToResurrect: aCell

	^(self isDead: aCell) and: [(self numberOfAliveNeighboursOf: aCell) = 3].! !

!GameOfLife methodsFor: 'testing' stamp: 'lm 5/15/2017 20:07:44'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^ (self isAlive: aCell) and: [numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]]! !

!GameOfLife methodsFor: 'testing' stamp: 'lm 5/15/2017 19:43:30'!
isAlive: aCell

	^(aliveCells includes: aCell) ! !

!GameOfLife methodsFor: 'testing' stamp: 'fz 5/16/2017 16:22:46'!
isDead: aCell

	^(aliveCells includes: aCell) not! !

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

!GameOfLife class methodsFor: 'messages' stamp: 'fz 5/16/2017 15:41:24'!
noAliveCellsAtStartMessage
	^'se necesita al menos una celula viva para empezar'.! !

!GameOfLife class methodsFor: 'messages' stamp: 'fz 5/16/2017 15:35:46'!
outOfBoundsMessage
	^'celda fuera de rango'.! !


!GameOfLife class methodsFor: 'initialization' stamp: 'fz 5/16/2017 16:15:11'!
withLiveCells: aCollectionOfAliveCells withBoard: aBoard
	
	(aCollectionOfAliveCells isEmpty) ifTrue: [self error: self noAliveCellsAtStartMessage].
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | (aBoard containsPoint: aCell)]) ifFalse: [self error: self outOfBoundsMessage].
	
	"se convierte la coleccion de celulas vivas a un set para que no haya repetidos"
	
	^self new initializeWith: aCollectionOfAliveCells asSet withBoard: aBoard.! !
