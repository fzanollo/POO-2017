!classDefinition: #CartTest category: #'TusLibros-Solution'!
TestCase subclass: #CartTest
	instanceVariableNames: 'emptyCatalog book1 book2 book1Catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:40:57'!
test01NoSePuedenAgregarLibrosQueNoSonDeLaEditorial
	|cart1|
	
	cart1 := Cart with: emptyCatalog.
	
	self
		should: [cart1 add: book1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cart bookNotFromEditorial
		].! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:32:30'!
test02UnCarritoNuevoEstaVacio
	|cart|
	
	cart := Cart with: emptyCatalog.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:48'!
test03SiAgregoUnLibroDejaDeEstarVacio
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	
	self deny: cart isEmpty. ! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:36'!
test04SiAgregoUnLibroTieneQueEstarEnElCarrito
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	
	self assert: (cart hasBook: book1).! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:23'!
test05UnLibroNoAgregadoNoEsta
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self deny: (cart hasBook: book1).! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:13'!
test06SiAgregoDosLibrosElTamañoEsDos
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	cart add: book1.
	
	self assert: cart size equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:04:25'!
test07SePuedenAgregarLibrosEnCantidades
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1 withQuantity: 2.
	
	self assert: (cart hasBook: book1).! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:04:03'!
test08SePuedePreguntarPorLaCantidadDeUnLibro
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1 withQuantity: 2.
	
	self assert: (cart quantityOf: book1) equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:11:16'!
test09NoSePuedenAgregarLibrosQueNoSonDeLaEditorialEnCantidades
	|cart|
	
	cart := Cart with: emptyCatalog.
	
	self
		should: [cart add: book1 withQuantity: 1] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart bookNotFromEditorial
		].! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:17:38'!
test10AgregarCantidadesMenoresOIgualesACeroDaError
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self
		should: [cart add: book1 withQuantity: 0] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart negativeOrNullQuantity
		].
	
	self
		should: [cart add: book1 withQuantity: -1] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart negativeOrNullQuantity
		].! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:19:16'!
test11AlSacarUnLibroYaNoEstaEnElCarrito
	|cart|
	
	cart := Cart with: book1Catalog.
	cart add: book1.
	
	cart remove: book1.
	
	self deny: (cart hasBook: book1).! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:24:47'!
test12SacarUnLibroNoAgregadoDaError
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self 
		should: [cart remove: book1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart bookNotFound
		].! !

!CarritoTest methodsFor: 'tests' stamp: 'lm 6/17/2017 17:34:38'!
test18ListarUnCarritoVacioDevuelveUnaListaVacia
	|carrito listaVacia|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	listaVacia := OrderedCollection new.
	self assert: carrito listCart  equals: listaVacia.
	! !

!CarritoTest methodsFor: 'tests' stamp: 'lm 6/17/2017 17:38:14'!
test19ListarUnCarritoDevuelveUnaListaDelContenido
	|carrito lista|
	
	carrito := Carrito forClient: client1ID withPassword: client1Pwd.
	
	carrito add: book1 withQuantity: 2.
	
	lista := OrderedCollection with: book1 with: 2.
	
	
	self assert: carrito listCart equals: lista.
	! !


!CartTest methodsFor: 'setUp' stamp: 'fz 6/19/2017 18:58:11'!
setUp
"Books"
	book1 := 'ISBN1'.
	book2 := 'ISBN2'.

"Catalogs"
	emptyCatalog := Set new.
	book1Catalog := Set with: book1.
	

! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'initialization' stamp: 'fz 6/19/2017 18:54:57'!
with: aCatalog
	catalog := aCatalog.
	content := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'fz 6/19/2017 19:13:27'!
add: aBookISBN
	self add: aBookISBN withQuantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'fz 6/19/2017 19:15:10'!
add: aBookISBN withQuantity: aQuantity
	(catalog includes: aBookISBN) ifFalse: [^self error: self class bookNotFromEditorial].
	(aQuantity <= 0) ifTrue: [^ self error: self class negativeOrNullQuantity].
	
	content add: aBookISBN withOccurrences: aQuantity.! !


!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:50:16'!
hasBook: aBookISBN
	^content includes: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:55:09'!
isEmpty
	^content size = 0.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 19:02:57'!
quantityOf: aBookISBN
	^content occurrencesOf: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:54:06'!
size
	^content size.! !


!Cart methodsFor: 'removing' stamp: 'fz 6/19/2017 19:25:43'!
remove: aBookISBN
	content remove: aBookISBN ifAbsent:[^self error: self class bookNotFound].! !


!Carrito methodsFor: 'as yet unclassified' stamp: 'lm 6/17/2017 17:47:07'!
listCart
	
	|lista| 
	
	lista := OrderedCollection new.
	
	(content keys) do: [ :bookISBN |
			lista add: bookISBN.
			lista add: (self quantityOf: bookISBN ).
		].
	
	^lista.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'fz 6/19/2017 18:23:55'!
with: aCatalog
	^self new with: aCatalog.! !


!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 19:25:23'!
bookNotFound
	^'book not found'.! !

!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 18:41:12'!
bookNotFromEditorial
	^'cant add books not from the editorial'.! !

!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 19:17:20'!
negativeOrNullQuantity
	^'negative or null quantities not allowed'.! !
