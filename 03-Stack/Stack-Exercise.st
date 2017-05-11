!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size topStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'fzanollo 5/11/2017 16:10:07'!
isEmpty
	^size = 0.! !

!OOStack methodsFor: 'testing' stamp: 'fzanollo 5/11/2017 16:45:42'!
size
	^size.! !


!OOStack methodsFor: 'initialization' stamp: 'fzanollo 5/11/2017 16:10:52'!
initialize
	size := 0.
	topStackElement := EmptyStackElement new.! !


!OOStack methodsFor: 'adding' stamp: 'fzanollo 5/11/2017 16:39:25'!
push: anElement 
	|newStackElement|
	
	newStackElement := NonEmptyStackElement with: anElement withPreviousElement: topStackElement.
	topStackElement := newStackElement.
	
	size := size +1.! !


!OOStack methodsFor: 'removing' stamp: 'fzanollo 5/11/2017 16:52:46'!
pop
	|element|
	
	element := topStackElement element.
	topStackElement := topStackElement previousElement.
	size := size -1.
	
	^element.! !


!OOStack methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:42:22'!
top
	^topStackElement element.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:05:11'!
element
	self subclassResponsibility! !

!StackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:05:24'!
previousElement
	self subclassResponsibility! !


!classDefinition: #EmptyStackElement category: #'Stack-Exercise'!
StackElement subclass: #EmptyStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:26:23'!
element
	^self error: OOStack stackEmptyErrorDescription.! !

!EmptyStackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:26:36'!
previousElement
	^self.! !


!classDefinition: #NonEmptyStackElement category: #'Stack-Exercise'!
StackElement subclass: #NonEmptyStackElement
	instanceVariableNames: 'element previousElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStackElement methodsFor: 'initialization' stamp: 'fzanollo 5/11/2017 16:30:36'!
with: anElement withPreviousElement: aPreviousElement
	element := anElement.
	previousElement := aPreviousElement.! !


!NonEmptyStackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:26:54'!
element
	^ element.! !

!NonEmptyStackElement methodsFor: 'accessing' stamp: 'fzanollo 5/11/2017 16:27:02'!
previousElement
	^ previousElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyStackElement class' category: #'Stack-Exercise'!
NonEmptyStackElement class
	instanceVariableNames: ''!

!NonEmptyStackElement class methodsFor: 'as yet unclassified' stamp: 'fzanollo 5/11/2017 16:33:35'!
with: anElement withPreviousElement: aPreviousElement
	|aNonEmptyStackElement|
	
	aNonEmptyStackElement := self new.
	aNonEmptyStackElement with: anElement withPreviousElement: aPreviousElement.
	^aNonEmptyStackElement.! !
