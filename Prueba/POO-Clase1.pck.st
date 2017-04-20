'From Cuis 5.0 of 7 November 2016 [latest update: #3068] on 20 April 2017 at 5:17:57 pm'!
'Description Please enter a description for this package'!
!provides: 'POO-Clase1' 1 0!
!classDefinition: #CustomerTests category: #'POO-Clase1'!
TestCase subclass: #CustomerTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'POO-Clase1'!
!classDefinition: 'CustomerTests class' category: #'POO-Clase1'!
CustomerTests class
	instanceVariableNames: ''!

!classDefinition: #Customer category: #'POO-Clase1'!
Object subclass: #Customer
	instanceVariableNames: 'birthDay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'POO-Clase1'!
!classDefinition: 'Customer class' category: #'POO-Clase1'!
Customer class
	instanceVariableNames: ''!

!classDefinition: #Prueba category: #'POO-Clase1'!
Object subclass: #Prueba
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'POO-Clase1'!
!classDefinition: 'Prueba class' category: #'POO-Clase1'!
Prueba class
	instanceVariableNames: 'm1'!

!classDefinition: #Sarasa category: #'POO-Clase1'!
Object subclass: #Sarasa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'POO-Clase1'!
!classDefinition: 'Sarasa class' category: #'POO-Clase1'!
Sarasa class
	instanceVariableNames: ''!


!CustomerTests methodsFor: 'as yet unclassified' stamp: 'FZ 4/4/2017 20:09:27'!
test01CustomerKnowsItsAge

	| aCustomer |

	aCustomer := Customer dateOfBirth: (Date year:1999 month: 3 day: 4).
	
	self assert: aCustomer age = 18.! !

!CustomerTests methodsFor: 'as yet unclassified' stamp: 'FZ 4/4/2017 20:21:54'!
test02CustomerKnowsItsName

	| aCustomer |

	aCustomer := Customer name: 'Juancho Tolargo' dateOfBirth: (Date year:1999 month: 3 day: 4).
	
	self assert: aCustomer name = 'Juancho Tolargo'.! !

!Customer methodsFor: 'as yet unclassified' stamp: 'FZ 4/4/2017 20:19:33'!
age
	^Date today yearNumber - birthDay yearNumber.! !

!Customer methodsFor: 'as yet unclassified' stamp: 'FZ 4/4/2017 20:17:02'!
bornOn: aDate 

	birthDay := aDate! !

!Customer class methodsFor: 'creation' stamp: 'FZ 4/4/2017 20:15:25'!
dateOfBirth: aDate 
	| newCustomer |
	
	newCustomer := self new.
	newCustomer bornOn: aDate.
	
	^newCustomer! !

!Prueba methodsFor: 'as yet unclassified' stamp: 'FZ 4/20/2017 17:09:45'!
m1
	"comment stating purpose of message"

	| a closure|
	
	a _ 10.
	closure _ [^ a+1].
	
	^closure value +5! !

!Prueba methodsFor: 'as yet unclassified' stamp: 'FZ 4/20/2017 17:14:45'!
sumar: aNumber con:otherNumber
	""

	
	|closure|

	closure _ [ :unColaborador :otroColaborador | ^unColaborador+otroColaborador+2].

	^(closure value:aNumber value:otherNumber) +10
	! !
