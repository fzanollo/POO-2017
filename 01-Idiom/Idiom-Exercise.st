!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'FZ 4/20/2017 21:20:50'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	
	customerBook := CustomerBook  new.
	self countMilliseconds: [customerBook addCustomerNamed: 'John Lennon'] assertLessThan: 50.
	
	
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FZ 4/20/2017 21:21:21'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self countMilliseconds: [customerBook removeCustomerNamed: paulMcCartney] assertLessThan: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'FZ 4/20/2017 21:25:10'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertCode: [customerBook addCustomerNamed: '']
		throws: Error 
		and: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'FZ 4/20/2017 21:25:30'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertCode: [customerBook removeCustomerNamed: 'Paul McCartney']
		throws: NotFound 
		and: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!IdiomTest methodsFor: 'posiblementeMoverATestCase' stamp: 'FZ 4/20/2017 21:24:44'!
assertCode: codeToTest throws: errorType and: codeToRun
	"se fija si codeToTest falla generando error de tipo errorType y si es asi corre codeToRun"

	[codeToTest value. 
	self fail]
		on: errorType
		do: codeToRun! !

!IdiomTest methodsFor: 'posiblementeMoverATestCase' stamp: 'FZ 4/20/2017 21:20:45'!
countMilliseconds: aClosure assertLessThan: howManyMilliseconds
	"devuelve los milisegundos que tarda en ejecutar el closure"
	
	|runningTime millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	runningTime := (millisecondsAfterRunning-millisecondsBeforeRunning).
	
	self assert: runningTime < 50 
	
	! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
