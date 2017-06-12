!classDefinition: #CarritoTest category: #'TusLibros-Solution'!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'client1 book1 book2 book1clon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:52:51'!
setUp

	client1 := Client withID: 1 withPassword: 'holaquehace'.
	book1 := Book withISBN: 1.
	book1clon := Book withISBN: 1.
	book2 := Book withISBN: 2.! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:23:31'!
test01unCarritoNuevoEstáVacio

	|aCart |

	aCart := Carrito ofClient: client1.
	
	self assert: aCart isEmpty.

	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:50:42'!
test02alAgregarUnElementoAlCarritoYaNoEstaVacio

	|aCart |
	
	aCart := Carrito ofClient: client1.
	aCart addBook: book1 withQuantity: 2.
	
	self deny: aCart isEmpty.
	

	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:50:53'!
test03alAgregarUnElementoAlCarritoEstaElElemYElTamañoDelCarritoEsUno

	|aCart bookQuantity|
	
	bookQuantity := 2.

	aCart := Carrito ofClient: client1.
	aCart addBook: book1 withQuantity: bookQuantity.
	
	self deny: aCart isEmpty.
	self assert: aCart size equals: 1.
	self assert: (aCart hasBook: book1).
	

	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 19:14:39'!
test04preguntarPorUnElementoQueNoEstaDevuelveFalso

	|aCart bookQuantity|
	
	bookQuantity := 2.

	aCart := Carrito ofClient: client1.
	aCart addBook: book1 withQuantity: bookQuantity.
	
	self deny: aCart isEmpty.
	self assert: aCart size equals: 1.
	self deny: (aCart hasBook: book2).
	

	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:50:11'!
test05alAgregarDosLibrosDistintosElTamañoEsDosYEstan

	|aCart bookQuantity|
	
	bookQuantity := 2.

	aCart := Carrito ofClient: client1.
	aCart addBook: book1 withQuantity: bookQuantity.
	aCart addBook: book2 withQuantity: bookQuantity.
	
	self deny: aCart isEmpty.
	self assert: aCart size equals: 2.
	self assert: (aCart hasBook: book2).
	self assert: (aCart hasBook: book1).
	

	! !

!CarritoTest methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 19:10:08'!
test06dosLibrosConMismoISBNSonConsideradosIguales

	|aCart bookQuantity|
	
	bookQuantity := 2.

	aCart := Carrito ofClient: client1.
	aCart addBook: book1 withQuantity: bookQuantity.
	
	self assert: book1 = book1clon.
	
	self assert: (aCart hasBook: book1clon).
	

	! !


!classDefinition: #Book category: #'TusLibros-Solution'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Book methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:20:52'!
withISBN: anISBN
	isbn := anISBN.! !


!Book methodsFor: 'testing' stamp: 'fz 6/12/2017 18:22:06'!
isbn
	^isbn.! !


!Book methodsFor: 'as yet unclassified' stamp: 'fz 6/12/2017 18:56:00'!
= aBook

	^(self isbn = aBook isbn).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'TusLibros-Solution'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:20:28'!
withISBN: anISBN
	^self new withISBN: anISBN.! !


!classDefinition: #Carrito category: #'TusLibros-Solution'!
Object subclass: #Carrito
	instanceVariableNames: 'contra idCliente size content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Carrito methodsFor: 'adding' stamp: 'fz 6/12/2017 19:15:32'!
addBook: aBook withQuantity: aQuantity
	size := size + 1.
	content add: (Association key: aBook isbn value: aQuantity).! !


!Carrito methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:30:48'!
withClientID: aClientID withPassword: aPassword
	contra := aPassword.
	idCliente := aClientID.
	size:=0.
	content := Dictionary new. ! !


!Carrito methodsFor: 'testing' stamp: 'fz 6/12/2017 19:15:39'!
hasBook: aBook
	^content includesKey: aBook isbn.! !

!Carrito methodsFor: 'testing' stamp: 'fz 6/12/2017 17:57:16'!
isEmpty
	^(size = 0).! !

!Carrito methodsFor: 'testing' stamp: 'fz 6/12/2017 18:09:04'!
size
	^size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #'TusLibros-Solution'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:24:31'!
ofClient: aClient 
	^self new withClientID: aClient id withPassword: aClient password.! !


!classDefinition: #Client category: #'TusLibros-Solution'!
Object subclass: #Client
	instanceVariableNames: 'id password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Client methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:19:51'!
withID: anID withPassword: aPassword
	id := anID.
	password := aPassword .! !


!Client methodsFor: 'testing' stamp: 'fz 6/12/2017 18:21:25'!
id
	^id.! !

!Client methodsFor: 'testing' stamp: 'fz 6/12/2017 18:21:48'!
password
	^password.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Client class' category: #'TusLibros-Solution'!
Client class
	instanceVariableNames: ''!

!Client class methodsFor: 'initialization' stamp: 'fz 6/12/2017 18:19:16'!
withID: anID withPassword: aPassword
	^self new withID: anID withPassword: aPassword.! !
