!classDefinition: #CarritoTest category: #'TusLibros-Solution'!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'client1ID client1Pwd book1 book2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 16:43:50'!
test01UnCarritoNuevoEstaVacio
	|carrito| 
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	self assert: carrito isEmpty.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:40:23'!
test02SiAgregoAlgoDejaDeEstarVacio
	|carrito| 
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	
	self deny: carrito isEmpty.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:40:05'!
test03SiAgregoAlgoTieneQueEstar
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	
	self assert: (carrito hasItem: book1).
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:39:56'!
test04SiAgregoDosLibrosElTamañoEsAdecuadoYAmbosEstan
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	carrito add: book2 withQuantity: 1.
	
	self assert: carrito size equals: 2.
	self assert: (carrito hasItem: book1).
	self assert: (carrito hasItem: book2).
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:39:49'!
test05UnLibroNoAgregadoNoEsta
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	
	self assert: (carrito hasItem: book1).
	self deny: (carrito hasItem: book2).
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:43:44'!
test06SePuedenAgregarLibrosConCantidades
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 2.
	
	self assert: (carrito quantityOf: book1) equals: 2.

	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:45:10'!
test07PreguntarCantidadDeUnLibroAgregadoDevuelveCorrectamenteAlHaberMasDeUno
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 2.
	carrito add: book2 withQuantity: 4.
	
	self assert: (carrito quantityOf: book1) equals: 2.
	self assert: (carrito quantityOf: book2) equals: 4.

	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/16/2017 19:48:41'!
test08PreguntarCantidadDeUnLibroNoAgregadoDevuelveCero
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	self assert: (carrito quantityOf: book1) equals: 0.

	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:18:22'!
test09AgregarCantidadesNegativasOCeroDaError
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	self 
		should: [carrito add: book1 withQuantity: 0]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Carrito negativeOrNullQuantityErrorMessage].
	
	self 
		should: [carrito add: book1 withQuantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Carrito negativeOrNullQuantityErrorMessage].! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:51:09'!
test10AlSacarElUnicoElementoElCarritoEstaVacioNuevamente
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	carrito remove: book1.
	
	self assert: (carrito isEmpty).! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:51:16'!
test11AlSacarUnElementoYaNoEstaEnElCarrito
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 1.
	carrito remove: book1.
	
	self deny: (carrito hasItem: book1).! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:51:23'!
test12SacarUnElementoNoAgregadoDaError
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	self 
		should: [carrito remove: book1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Carrito elementNotFoundErrorMessage].! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:23:15'!
test13AgregarUnLibroExistenteAgregaALaCantidadExistente
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.

	carrito add: book1 withQuantity: 1.	
	carrito add: book1 withQuantity: 2.
	
	self assert: (carrito quantityOf: book1) equals: 3.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:32:39'!
test14AgregarUnLibroExistenteNoAumentaElTamañoDelCarrito
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.

	carrito add: book1 withQuantity: 1.	
	carrito add: book1 withQuantity: 2.
	
	self assert: (carrito size) equals: 1.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:35:00'!
test15SePuedeSacarCiertaCantidadDeUnLibroAgregado
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 3.	
	
	carrito remove: book1 quantity: 2.
	
	self assert: (carrito quantityOf: book1) equals: 1.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:38:00'!
test16AlSacarTodosOMasCantidadDeUnLibroAgregadoSeQuita
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 3.	
	
	carrito remove: book1 quantity: 3.
	
	self deny: (carrito hasItem: book1).
	! !

!CarritoTest methodsFor: 'tests' stamp: 'fz 6/17/2017 16:52:48'!
test17SacarCantidadesNegativasOCeroDaError
	|carrito|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	carrito add: book1 withQuantity: 3.
	
	self 
		should: [carrito remove: book1 quantity: 0]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Carrito negativeOrNullQuantityErrorMessage].
	
	self 
		should: [carrito remove: book1 quantity: -1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Carrito negativeOrNullQuantityErrorMessage].! !


!CarritoTest methodsFor: 'setUp' stamp: 'fz 6/16/2017 19:38:56'!
setUp

	client1ID := 'sarasa'.
	client1Pwd := '1234'.
	
	book1 := 'isbn1'.
	book2 := 'isbn2'.! !


!classDefinition: #Carrito category: #'TusLibros-Solution'!
Object subclass: #Carrito
	instanceVariableNames: 'size clientID password content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Carrito methodsFor: 'testing' stamp: 'fz 6/16/2017 18:11:51'!
hasItem: aBookISBN
	^content keys hasLiteral: aBookISBN.! !

!Carrito methodsFor: 'testing' stamp: 'fz 6/16/2017 16:33:03'!
isEmpty
	^size = 0.! !

!Carrito methodsFor: 'testing' stamp: 'fz 6/16/2017 19:49:06'!
quantityOf: aBookISBN
	^ content at: aBookISBN ifAbsent: [0].! !

!Carrito methodsFor: 'testing' stamp: 'fz 6/16/2017 16:49:48'!
size
	^size.! !


!Carrito methodsFor: 'adding' stamp: 'fz 6/17/2017 16:30:33'!
add: aBookISBN withQuantity: aQuantity
	|quantity|
	
	(aQuantity <= 0) ifTrue: [^ self error: self class negativeOrNullQuantityErrorMessage].

	(self hasItem: aBookISBN) ifFalse: [size := size + 1].
	
	quantity := aQuantity + (self quantityOf: aBookISBN).	
	content add:(Association key: aBookISBN value: quantity).! !


!Carrito methodsFor: 'initialize' stamp: 'fz 6/16/2017 17:42:51'!
forClient: aClientID withPassword: aPassword 
	clientID := aClientID.
	password := aPassword.
	
	size := 0.
	content :=  Dictionary new.! !


!Carrito methodsFor: 'removing' stamp: 'fz 6/17/2017 16:51:43'!
remove: aBookISBN
	content removeKey: aBookISBN ifAbsent: [self error: self class elementNotFoundErrorMessage].
	size := size-1.! !

!Carrito methodsFor: 'removing' stamp: 'fz 6/17/2017 16:51:03'!
remove: aBookISBN quantity: aQuantity
	|newQuantity|
	
	(aQuantity <= 0) ifTrue: [^ self error: self class negativeOrNullQuantityErrorMessage].
	
	newQuantity := (self quantityOf: aBookISBN) - aQuantity.
	
	(newQuantity <= 0) ifTrue:[self remove: aBookISBN] ifFalse:[content at: aBookISBN put: (newQuantity)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #'TusLibros-Solution'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'initialization' stamp: 'fz 6/16/2017 16:37:48'!
forClient: aClientID withPassword: aPassword 
	^self new forClient: aClientID withPassword: aPassword.! !


!Carrito class methodsFor: 'messages' stamp: 'fz 6/16/2017 20:10:27'!
elementNotFoundErrorMessage
	^'element not found'.! !

!Carrito class methodsFor: 'messages' stamp: 'fz 6/17/2017 16:48:58'!
negativeOrNullQuantityErrorMessage
	^ 'negative or null quantities not allowed'.! !
