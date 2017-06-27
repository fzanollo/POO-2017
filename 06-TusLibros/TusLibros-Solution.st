!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'emptyCatalog book1 book2 book1Catalog notEmptyCart expiredYesterdayCreditCard validUntilTodayCreditCard salesBook booksCatalog merchantProcessorValidCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:44:05'!
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:32:30'!
test02UnCarritoNuevoEstaVacio
	|cart|
	
	cart := Cart with: emptyCatalog.
	
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:48'!
test03SiAgregoUnLibroDejaDeEstarVacio
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	
	self deny: cart isEmpty. ! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:36'!
test04SiAgregoUnLibroTieneQueEstarEnElCarrito
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	
	self assert: (cart hasBook: book1).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:23'!
test05UnLibroNoAgregadoNoEsta
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self deny: (cart hasBook: book1).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 18:58:13'!
test06SiAgregoDosLibrosElTamañoEsDos
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1.
	cart add: book1.
	
	self assert: cart size equals: 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:04:25'!
test07SePuedenAgregarLibrosEnCantidades
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1 withQuantity: 2.
	
	self assert: (cart hasBook: book1).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 19:04:03'!
test08SePuedePreguntarPorLaCantidadDeUnLibro
	|cart|
	
	cart := Cart with: book1Catalog.
	
	cart add: book1 withQuantity: 2.
	
	self assert: (cart quantityOf: book1) equals: 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:06'!
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:13'!
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/19/2017 21:50:17'!
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 19:53:20'!
test12CheckoutConUnaTarjetaVencidaDaError

	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: 'tarjeta vencida'].
	
	cashier := Cashier withCart: notEmptyCart withCard: expiredYesterdayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut.]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Cashier expiredCard.
		self assert: salesBook isEmpty.
	]
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 19:48:58'!
test13SePuedeRealizarCheckoutConUnaTarjetaValida

	|cashier salesBook|
	
	salesBook := LinkedList new.
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard.
	
	self assert: cashier checkOut .
	self deny: salesBook isEmpty.


! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 19:53:54'!
test14CheckoutConUnCarritoVacioDaError

	|cashier salesBook emptyCart|

	emptyCart := Cart with: book1Catalog.
	salesBook := LinkedList new.
	
	cashier := Cashier withCart: emptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard.
	
	self should: [cashier checkOut]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'carrito vacio'.
		self assert: salesBook isEmpty.
	]
! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 19:49:08'!
test15CheckoutCorrectoSeAgregaAlLibroDeVentas
	|cashier salesBook|
	
	salesBook := LinkedList new.
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard.
	
	cashier checkOut.
	
	self assert: salesBook notEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 19:49:14'!
test16CheckoutCorrectoAgregaAlLibroDeVentasElValorDelCarrito
	|cashier salesBook|
	
	salesBook := LinkedList new.
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard.
	
	cashier checkOut.
	
	self assert: salesBook last equals: notEmptyCart totalAmount.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/21/2017 16:25:51'!
test17CarritoCalculaCorrectamenteElImporteTotal
	|cart|
	
	cart := Cart with: booksCatalog.
	
	cart add: book1.
	cart add: book2 withQuantity: 2.
	
	self assert: cart totalAmount equals: 40.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:08:26'!
test18CheckoutConTarjetaRobadaDaError
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor stolenCard].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ('Error: ' append: MerchantProcessor stolenCard).
		self assert: salesBook isEmpty.
	]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:11:58'!
test19CheckoutConTarjetaSinCreditoDaError
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor withoutFundsCreditCard].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ('Error: ' append: MerchantProcessor withoutFundsCreditCard).
		self assert: salesBook isEmpty.
	]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:12:54'!
test20CheckoutConTarjetaVencidaDaErrorYNoSeLlamaAMerchantProcessor
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor expiredCard].
	
	cashier := Cashier withCart: notEmptyCart withCard: expiredYesterdayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Cashier expiredCard.
	].

	self assert: merchantProcessor calls equals: 0.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:16:31'!
test21CheckoutConTarjetaValidaDebitaDesdeMerchantProcessor
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [true].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	cashier checkOut.
	self assert: merchantProcessor calls equals: 1.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:31:20'!
test22SeCreaUnCarritoParaUnUsuarioYContraseñaValidos
	|restInterface user pass userPasswordDictionary cartID|
	
	user := 'user1'.
	pass := 'user1Pass'.
	
	userPasswordDictionary := Dictionary new.
	userPasswordDictionary at: user put: pass.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: userPasswordDictionary.
	
	cartID := restInterface createCartForClient: user withPass: pass.
	
	self assert: (restInterface listCart: cartID) isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:52:43'!
test23CrearUnCarritoConUsuarioInvalidoDaError
	|restInterface user pass userPasswordDictionary|
	
	user := 'user1'.
	pass := 'user1Pass'.
	
	userPasswordDictionary := Dictionary new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: userPasswordDictionary.
	
	self should: [restInterface createCartForClient: user withPass: pass] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidUser.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:52:57'!
test24CrearUnCarritoConPasswordInvalidoDaError
	|restInterface user pass userPasswordDictionary|
	
	user := 'user1'.
	pass := 'user1Pass'.
	
	userPasswordDictionary := Dictionary new.
	userPasswordDictionary at: user put: pass.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: userPasswordDictionary.
	
	self should: [restInterface createCartForClient: user withPass: 'sarasa'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidPassword.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 20:58:28'!
test25LosCarritosTienenIDsUnicos
	|restInterface user1 pass1 user2 pass2 userPasswordDictionary cartID1 cartID2|
	
	user1 := 'user1'.
	pass1 := 'user1Pass'.
	
	user2 := 'user2'.
	pass2 := 'user2Pass'.
	
	userPasswordDictionary := Dictionary new.
	userPasswordDictionary at: user1 put: pass1.
	userPasswordDictionary at: user2 put: pass2.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: userPasswordDictionary.
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	cartID2 := restInterface createCartForClient: user2 withPass: pass2.
	
	self deny: cartID1 = cartID2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/26/2017 21:43:32'!
test26SiAgregoUnLibroTieneQueEstarEnElListadoDelCarrito
	|restInterface user1 pass1 userPasswordDictionary cartID1|
	
	user1 := 'user1'.
	pass1 := 'user1Pass'.
	
	userPasswordDictionary := Dictionary new.
	userPasswordDictionary at: user1 put: pass1.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: userPasswordDictionary.
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	
	restInterface addToCart: cartID1 bookISBN: book1 quantity: 2.
	
	self assert: (restInterface listCart: cartID1) size equals: 1.
	self assert: ((restInterface listCart: cartID1) at: book1) equals: 2.! !


!TusLibrosTest methodsFor: 'setUp' stamp: 'fz 6/26/2017 19:52:33'!
setUp
"Books"
	book1 := 'ISBN1'.
	book2 := 'ISBN2'.

"Catalogs"
	emptyCatalog := Dictionary new.
	book1Catalog := Dictionary with: (Association key: book1 value: 20).
	
	booksCatalog := Dictionary new.
	booksCatalog at: book1 put: 20.
	booksCatalog at: book2 put: 10.

"Carts"	
	notEmptyCart := Cart with: book1Catalog.
	notEmptyCart add: book1.

"Cards"
	expiredYesterdayCreditCard := Date yesterday.
	validUntilTodayCreditCard := Date today.
	
"Merchant Processor simulators"
	merchantProcessorValidCard := MerchantProcessorSimulator withBehaviour: [true].
	
	

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

!Cart methodsFor: 'adding' stamp: 'fz 6/21/2017 16:19:56'!
add: aBookISBN withQuantity: aQuantity
	(catalog includesKey: aBookISBN) ifFalse: [^self error: self class bookNotFromEditorial].
	
	(aQuantity isKindOf: Integer) ifFalse: [^self error: self class notIntegerQuantities].
	(aQuantity <= 0) ifTrue: [^ self error: self class negativeOrNullQuantity].
	
	content add: aBookISBN withOccurrences: aQuantity.! !


!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:50:16'!
hasBook: aBookISBN
	^content includes: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:55:09'!
isEmpty
	^content size = 0.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/26/2017 21:36:33'!
list
	|list|
	
	list := Dictionary new.
	
	content do:[:aBookISBN | list at: aBookISBN put: (content occurrencesOf: aBookISBN)].
	
	^list.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 19:02:57'!
quantityOf: aBookISBN
	^content occurrencesOf: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/19/2017 18:54:06'!
size
	^content size.! !

!Cart methodsFor: 'testing' stamp: 'fz 6/21/2017 16:18:16'!
totalAmount
	|total|
	total := 0.
	
	content do: [:aBookISBN | total := total + catalog at:aBookISBN].
	
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'fz 6/19/2017 18:23:55'!
with: aCatalog
	^self new with: aCatalog.! !

!Cart class methodsFor: 'initialization' stamp: 'fz 6/26/2017 20:40:22'!
with: aCatalog andID: anID
	^self new with: aCatalog andID: anID.! !


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
	instanceVariableNames: 'card date cart salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'fz 6/26/2017 19:44:29'!
checkOut
		
	(card < date) ifTrue:[^ self error: self class expiredCard].
	(cart isEmpty) ifTrue:[^self error: 'carrito vacio'].
	
	[merchantProcessor debit: cart totalAmount from: card] ifError: [:anError | ^self error: anError].
	
	salesBook add: cart totalAmount.	
	^ true.	! !


!Cashier methodsFor: 'initialization' stamp: 'fz 6/26/2017 19:01:45'!
withCart: aCart withCard: aCard withCurrentDate: theCurrentDate withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor
	cart := aCart.
	card := aCard.
	date := theCurrentDate.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'messages' stamp: 'lm 6/20/2017 16:18:12'!
expiredCard
	^ 'Cannot Check Out with Expired Card.'! !


!Cashier class methodsFor: 'initialization' stamp: 'fz 6/26/2017 19:01:10'!
withCart: aCart withCard: aCard withCurrentDate: theCurrentDate withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor
	^self new withCart: aCart withCard: aCard withCurrentDate: theCurrentDate withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'debit' stamp: 'fz 6/26/2017 18:55:23'!
debit: anAmount from: aCard
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'TusLibros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:13:17'!
expiredCard
	^'expired card'! !

!MerchantProcessor class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:05:50'!
stolenCard
	^'stolen card'.! !

!MerchantProcessor class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:12:23'!
withoutFundsCreditCard
	^'credit card out of funds'! !


!classDefinition: #MerchantProcessorInterface category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!


!classDefinition: #MerchantProcessorSimulator category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'behaviour calls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessorSimulator methodsFor: 'testing' stamp: 'fz 6/26/2017 20:01:22'!
calls
	^ calls.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'fz 6/26/2017 20:01:43'!
withBehaviour: aBehaviour 
	calls := 0.
	behaviour := aBehaviour.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'fz 6/26/2017 20:01:57'!
debit: anAmount from: aCard
	calls := calls + 1.
	^behaviour value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #'TusLibros-Solution'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'initialization' stamp: 'fz 6/26/2017 19:46:04'!
withBehaviour: aBehaviour 
	^self new withBehaviour: aBehaviour.! !


!classDefinition: #RestInterface category: #'TusLibros-Solution'!
Object subclass: #RestInterface
	instanceVariableNames: 'catalog usersInfo lastCartID carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!RestInterface methodsFor: 'initialization' stamp: 'fz 6/26/2017 21:17:24'!
withCatalog: theCatalog withUsersInfo: theUsersInfo
	catalog := theCatalog.
	usersInfo := theUsersInfo.
	
	carts := Dictionary new.
	lastCartID := 0.! !


!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/26/2017 21:16:20'!
addToCart: anID bookISBN: aBookISBN quantity: aQuantity
	|cart|
	cart := carts at: anID.
	
	cart add: aBookISBN withQuantity: aQuantity.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/26/2017 21:18:29'!
createCartForClient: user withPass: pass
	|cartID|
	
	((usersInfo at: user ifAbsent:[^self error: RestInterface invalidUser]) = pass) 
		ifFalse: [^self error: RestInterface invalidPassword].
		
	cartID := self nextCartID.
	carts at: cartID put: (Cart with: catalog).
	
	^cartID.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/26/2017 21:20:20'!
listCart: anID
	|cart|
	
	cart := carts at: anID.
	^cart list.! !


!RestInterface methodsFor: 'private' stamp: 'fz 6/26/2017 21:00:27'!
nextCartID
	lastCartID := lastCartID + 1.
	^lastCartID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #'TusLibros-Solution'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'initialization' stamp: 'fz 6/26/2017 20:34:53'!
withCatalog: theCatalog withUsersInfo: theUsersInfo
	^self new withCatalog: theCatalog withUsersInfo: theUsersInfo.! !


!RestInterface class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:50:09'!
invalidPassword
	^'invalid password'.! !

!RestInterface class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:50:00'!
invalidUser
	^'invalid user'.! !
