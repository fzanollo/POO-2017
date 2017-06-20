!classDefinition: #CartTest category: #'TusLibros-Solution'!
TestCase subclass: #CartTest
	instanceVariableNames: 'emptyCatalog book1 book2 book1Catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:44:05'!
test01NoSePuedenAgregarLibrosQueNoSonDeLaEditorial
	|cart|
	
	cart := Cart with: emptyCatalog.
	
	self
		should: [cart add: book1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Cart bookNotFromEditorial.
			self deny: (cart hasBook: book1).
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

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:06'!
test09NoSePuedenAgregarLibrosQueNoSonDeLaEditorialEnCantidades
	|cart|
	
	cart := Cart with: emptyCatalog.
	
	self
		should: [cart add: book1 withQuantity: 1] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart bookNotFromEditorial.
			self deny: (cart hasBook: book1).
		].! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:13'!
test10AgregarCantidadesMenoresOIgualesACeroDaError
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self
		should: [cart add: book1 withQuantity: 0] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart negativeOrNullQuantity.
			self deny: (cart hasBook: book1).
		].
	
	self
		should: [cart add: book1 withQuantity: -1] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart negativeOrNullQuantity.
			self deny: (cart hasBook: book1).
		].! !

!CartTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:17'!
test11AgregarCantidadesNoEnterasDaError
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self
		should: [cart add: book1 withQuantity: 1.5] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart notIntegerQuantities.
			self deny: (cart hasBook: book1).
		].! !


!CartTest methodsFor: 'setUp' stamp: 'fz 6/19/2017 18:58:11'!
setUp
"Books"
	book1 := 'ISBN1'.
	book2 := 'ISBN2'.

"Catalogs"
	emptyCatalog := Set new.
	book1Catalog := Set with: book1.
	

! !


!classDefinition: #CashierTest category: #'TusLibros-Solution'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:37:36'!
test01CheckoutConUnaTarjetaVencidaDaError

	|cashier expiredCreditCard|
	
	expiredCreditCard :=  Date yesterday.
	
	cashier := Cashier withCard: expiredCreditCard withCurrentDate: Date today.
	.
	self should: [cashier checkOut.]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier expiredCard.
		"chequear  que no se halla llevado a cabo la compra, es decir no debe estar en el libro de ventas"
	]

! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:39:30'!
test02SePuedeRealizarCheckoutConUnaTarjetaValida

	|cashier expiredCreditCard|
	
	expiredCreditCard :=  Date today.
	
	cashier := Cashier withCard: expiredCreditCard withCurrentDate: Date today.
	
	self assert: cashier checkOut .
	
	"también tenemos que verificar que esté en el libro de ventas"

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

!Cart methodsFor: 'adding' stamp: 'fz 6/19/2017 21:23:55'!
add: aBookISBN withQuantity: aQuantity
	(catalog includes: aBookISBN) ifFalse: [^self error: self class bookNotFromEditorial].
	(aQuantity isKindOf: Integer) ifFalse: [^self error: self class notIntegerQuantities].
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

!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 21:20:26'!
notIntegerQuantities
	^'not integer quantities not allowed'.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'card date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!


!Cashier methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:36:15'!
checkOut
		
	(card < date) ifTrue:[^ self error: self class expiredCard.].
	
	^ true.	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:35:46'!
withCard: aCard withCurrentDate: theCurrentDate
	card := aCard.
	date := theCurrentDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:18:12'!
expiredCard
	^ 'Cannot Check Out with Expired Card.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'lm 6/20/2017 16:33:32'!
withCard: aCard withCurrentDate: currentDate
	^ self new withCard: aCard withCurrentDate: currentDate.! !
