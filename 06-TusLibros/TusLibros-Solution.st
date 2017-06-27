!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'emptyCatalog book1 book2 book1Catalog notEmptyCart expiredYesterdayCreditCard validUntilTodayCreditCard salesBook booksCatalog merchantProcessorValidCard noUsers user1 pass1 twoUsers user2 pass2 sharedSalesBook'
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 15:30:53'!
test11AgregarCantidadesNoEnterasDaError
	|cart|
	
	cart := Cart with: book1Catalog.
	
	self
		should: [cart add: book1 withQuantity: 1.5] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cart notIntegerQuantity.
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:16:24'!
test18CheckoutConTarjetaRobadaDaError
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor stolenCard].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: MerchantProcessor stolenCard.
		self assert: salesBook isEmpty.
	]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:16:15'!
test19CheckoutConTarjetaSinCreditoDaError
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor withoutFundsCreditCard].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: MerchantProcessor withoutFundsCreditCard.
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

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:15:31'!
test22ElMerchantProcessorCaidoLevantaUnError
	|cashier salesBook merchantProcessor|
	
	salesBook := LinkedList new.
	
	merchantProcessor := MerchantProcessorSimulator withBehaviour: [self error: MerchantProcessor notReachable].
	
	cashier := Cashier withCart: notEmptyCart withCard: validUntilTodayCreditCard withCurrentDate: Date today withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkOut] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: MerchantProcessor notReachable.
		self assert: salesBook isEmpty.
	]! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:03:40'!
test23SeCreaUnCarritoParaUnUsuarioYContraseñaValidos
	|restInterface cartID|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	cartID := restInterface createCartForClient: user1 withPass: pass1.
	
	self assert: (restInterface listCart: cartID) isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:14:27'!
test24CrearUnCarritoConUsuarioInvalidoDaError
	|restInterface|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self should: [restInterface createCartForClient: 'pepito' withPass: pass1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidUser.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:14:32'!
test25CrearUnCarritoConPasswordInvalidoDaError
	|restInterface|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self should: [restInterface createCartForClient: user1 withPass: 'sarasa'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidPassword.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:03:53'!
test26LosCarritosTienenIDsUnicos
	|restInterface cartID1 cartID2|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	cartID2 := restInterface createCartForClient: user2 withPass: pass2.
	
	self deny: cartID1 = cartID2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:03:58'!
test27SiAgregoUnLibroTieneQueEstarEnElListadoDelCarrito
	|restInterface cartID1|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	
	restInterface addToCart: cartID1 bookISBN: book1 quantity: 2.
	
	self assert: (restInterface listCart: cartID1) size equals: 1.
	self assert: ((restInterface listCart: cartID1) at: book1) equals: 2.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:04:04'!
test28AgregarUnLibroConIDCarritoInvalidoDaError
	|restInterface cartsBefore|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: noUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	cartsBefore := restInterface carts.
	
	self should: [restInterface addToCart: 1 bookISBN: book1 quantity: 2] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
			self assert: restInterface carts equals: cartsBefore.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:04:08'!
test29AgregarUnLibroConBookISBNInvalidoDaError
	|restInterface cartID1|
	
	restInterface := RestInterface withCatalog: emptyCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	
	self should: [restInterface addToCart: cartID1 bookISBN: book1 quantity: 2] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart bookNotFromEditorial.
			self assert: (restInterface listCart: cartID1) isEmpty.
		].
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:04:13'!
test30AgregarUnLibroConCantidadInvalidaDaError
	|restInterface cartID1|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	cartID1 := restInterface createCartForClient: user1 withPass: pass1.
	
	self should: [restInterface addToCart: cartID1 bookISBN: book1 quantity: 0] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart negativeOrNullQuantity.
			self assert: (restInterface listCart: cartID1) isEmpty.
		].
	
	self should: [restInterface addToCart: cartID1 bookISBN: book1 quantity: -1] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart negativeOrNullQuantity.
			self assert: (restInterface listCart: cartID1) isEmpty.
		].
	
	self should: [restInterface addToCart: cartID1 bookISBN: book1 quantity: 1.5] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cart notIntegerQuantity.
			self assert: (restInterface listCart: cartID1) isEmpty.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:04:18'!
test31ListarUnCarritoInvalidoDaError
	|restInterface|
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: noUsers withSalesBook: sharedSalesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today..
	
	self should: [restInterface listCart: 1] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:13:00'!
test32CheckOutCarritoValidoAgregaAlLibroDeComprasYDebitaDeMerchantProcessor
	|restInterface cartID salesBook mpCallsBefore|
	
	salesBook := LinkedList new.
	
	mpCallsBefore := merchantProcessorValidCard calls.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	cartID := restInterface createCartForClient: user1 withPass: pass1.
	restInterface addToCart: cartID bookISBN: book1 quantity: 2.
	
	restInterface checkOutCart: cartID fromCard: validUntilTodayCreditCard.
	
	self deny: salesBook isEmpty.
	self assert: merchantProcessorValidCard calls equals: mpCallsBefore + 1.
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:19:44'!
test33UnaVezRealizadoElCheckOutNoSePuedeUsarElCarrito
	|restInterface cartID salesBook|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	cartID := restInterface createCartForClient: user1 withPass: pass1.
	restInterface addToCart: cartID bookISBN: book1 quantity: 2.
	
	restInterface checkOutCart: cartID fromCard: validUntilTodayCreditCard.
	
	self should: [restInterface addToCart: cartID bookISBN: book1 quantity: 2] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:26:31'!
test34CheckOutConIDDeCarritoInvalidoDaError
	|restInterface salesBook|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self should: [restInterface checkOutCart: 1 fromCard: validUntilTodayCreditCard] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:43:12'!
test35CrearUnaTarjetaConNombreDeDueñoDeTarjetaVacioDaError

	self should: [Card withNumber: 1234 withExpirationDate: Date today withOwnerName: ''.] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Card emptyOwnerName.
		].
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 16:50:10'!
test36ListarLasComprasDeUnClienteQueNoComproRetornaVacio
	|restInterface salesBook|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self assert: (restInterface listPurchasesOf: user1 withPass: pass1) isEmpty.
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:13:27'!
test37ListarLasComprasDeUnClienteQueComproRetornaCorrectamente
	|restInterface salesBook cartID|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	cartID := restInterface createCartForClient: user1 withPass: pass1.
	restInterface addToCart: cartID bookISBN: book1 quantity: 2.
	
	restInterface checkOutCart: cartID fromCard: validUntilTodayCreditCard.
	
	self deny: (restInterface listPurchasesOf: user1 withPass: pass1) isEmpty.
	self assert: (restInterface listPurchasesOf: user1 withPass: pass1) last amount equals: 40.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:17:32'!
test38ListarLasComprasDeUnClienteInvalidoRetornaError
	|restInterface salesBook|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self should: [restInterface listPurchasesOf: 'pepelui' withPass: pass1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidUser.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:18:25'!
test39ListarLasComprasDeUnPasswordInvalidoRetornaError
	|restInterface salesBook|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	self should: [restInterface listPurchasesOf: user1 withPass: 'sarasa'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidPassword.
		].! !

!TusLibrosTest methodsFor: 'tests' stamp: 'fz 6/27/2017 17:33:50'!
test40SiPasaron30MinDeLaUltimaOperacionElCarritoEsInvalido
	|restInterface salesBook cartID|
	
	salesBook := LinkedList new.
	
	restInterface := RestInterface withCatalog: booksCatalog withUsersInfo: twoUsers withSalesBook: salesBook withMerchantProcessor: merchantProcessorValidCard withCurrentDate: Date today.
	
	cartID := restInterface createCartForClient: user1 withPass: pass1.
	restInterface addToCart: cartID bookISBN: book1 quantity: 2.
	
	restInterface thirtyMinutesLater.
	
	self should: [restInterface addToCart: cartID bookISBN: book1 quantity: 2] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].
	
	self should: [restInterface listCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].
	
	self should: [restInterface checkOutCart: cartID fromCard: validUntilTodayCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RestInterface invalidCartID.
		].! !


!TusLibrosTest methodsFor: 'setUp' stamp: 'fz 6/27/2017 17:03:03'!
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

"SalesBook"
	sharedSalesBook := LinkedList new.

"Carts"	
	notEmptyCart := Cart with: book1Catalog.
	notEmptyCart add: book1.

"Cards"
	expiredYesterdayCreditCard := Card withNumber: 1234 withExpirationDate: Date yesterday withOwnerName: 'pepe'.
	validUntilTodayCreditCard := Card withNumber: 4321 withExpirationDate: Date today withOwnerName: 'marta'.
	
"Merchant Processor simulators"
	merchantProcessorValidCard := MerchantProcessorSimulator withBehaviour: [true].

"Users data"
	user1 := 'user1'.
	pass1 := 'user1Pass'.
	
	user2 := 'user2'.
	pass2 := 'user2Pass'.
	
	noUsers := Dictionary new.
	twoUsers := Dictionary new.
	twoUsers at: user1 put: pass1.
	twoUsers at: user2 put: pass2.
	
	
	
	

! !


!classDefinition: #Card category: #'TusLibros-Solution'!
Object subclass: #Card
	instanceVariableNames: 'number expirationDate ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Card methodsFor: 'initialization' stamp: 'fz 6/27/2017 16:38:45'!
withNumber: aNumber withExpirationDate: aDate withOwnerName: aName
	number := aNumber.
	expirationDate := aDate.
	ownerName := aName.! !


!Card methodsFor: 'accessing' stamp: 'fz 6/27/2017 16:39:40'!
expirationDate
	^expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #'TusLibros-Solution'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'fz 6/27/2017 16:42:29'!
withNumber: aNumber withExpirationDate: aDate withOwnerName: aName
	(aName = '') ifTrue: [self error: self emptyOwnerName].
	^self new withNumber: aNumber withExpirationDate: aDate withOwnerName: aName.! !


!Card class methodsFor: 'messages' stamp: 'fz 6/27/2017 16:43:56'!
emptyOwnerName
	^'empty card owner name'.! !


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

!Cart methodsFor: 'adding' stamp: 'fz 6/27/2017 15:31:14'!
add: aBookISBN withQuantity: aQuantity
	(catalog includesKey: aBookISBN) ifFalse: [^self error: self class bookNotFromEditorial].
	
	(aQuantity isKindOf: Integer) ifFalse: [^self error: self class notIntegerQuantity].
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


!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 18:41:12'!
bookNotFromEditorial
	^'cant add books not from the editorial'.! !

!Cart class methodsFor: 'messages' stamp: 'fz 6/19/2017 19:17:20'!
negativeOrNullQuantity
	^'negative or null quantities not allowed'.! !

!Cart class methodsFor: 'messages' stamp: 'fz 6/27/2017 15:31:02'!
notIntegerQuantity
	^'not integer quantities not allowed'.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'card date cart salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'checkout' stamp: 'fz 6/27/2017 16:39:15'!
checkOut
		
	(card expirationDate < date) ifTrue:[^ self error: self class expiredCard].
	(cart isEmpty) ifTrue:[^self error: 'carrito vacio'].
	
	merchantProcessor debit: cart totalAmount from: card.
	
	salesBook add: cart totalAmount.	
	^ true.	! !


!Cashier methodsFor: 'initialization' stamp: 'fz 6/26/2017 19:01:45'!
withCart: aCart withCard: aCard withCurrentDate: theCurrentDate withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor
	cart := aCart.
	card := aCard.
	date := theCurrentDate.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'private' stamp: 'fz 6/27/2017 17:13:44'!
amount
	^cart totalAmount.! !

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

!MerchantProcessor class methodsFor: 'messages' stamp: 'fz 6/26/2017 22:23:13'!
notReachable
	^'merchant processor not reachable'! !

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
	instanceVariableNames: 'catalog usersInfo lastCartID carts salesBook merchantProcessor date usersPurchases usersCurrentCart cartsLastUsedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!RestInterface methodsFor: 'initialization' stamp: 'fz 6/27/2017 17:31:30'!
withCatalog: theCatalog withUsersInfo: theUsersInfo withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withCurrentDate: aDate 
	catalog := theCatalog.
	usersInfo := theUsersInfo.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	date := aDate.
	
	carts := Dictionary new.
	lastCartID := 0.
	usersPurchases := Dictionary new.
	usersCurrentCart := Dictionary new.
	cartsLastUsedTime := Dictionary new.! !


!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/27/2017 15:38:32'!
addToCart: anID bookISBN: aBookISBN quantity: aQuantity
	|cart|
	cart := self getCart: anID.
	
	cart add: aBookISBN withQuantity: aQuantity.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/27/2017 17:10:31'!
checkOutCart: anID fromCard: aCard 
	|cart cartUser cashier|
	
	cart := self getCart: anID.
	
	cashier := Cashier withCart: cart withCard: aCard withCurrentDate: date withSalesBook: salesBook withMerchantProcessor: merchantProcessor.
	
	cashier checkOut.
	
	carts removeKey: anID.
	
	cartUser := usersCurrentCart at: anID.
	self addPurchase: cashier toHistoryOf: cartUser.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/27/2017 17:31:58'!
createCartForClient: user withPass: pass
	|cartID|
	
	self checkUser: user password: pass.
		
	cartID := self nextCartID.
	carts at: cartID put: (Cart with: catalog).
	
	usersCurrentCart at: cartID put: user.
	cartsLastUsedTime at: cartID put: 0.
	
	^cartID.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/27/2017 15:38:47'!
listCart: anID
	|cart|
		
	cart := self getCart: anID.
	
	^cart list.! !

!RestInterface methodsFor: 'RESTmessages' stamp: 'fz 6/27/2017 17:19:32'!
listPurchasesOf: user withPass: pass
	self checkUser: user password: pass.
		
	^usersPurchases at: user ifAbsent:[OrderedCollection new].	! !


!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 17:12:37'!
addPurchase: purchase toHistoryOf: user
	(usersPurchases includesKey: user) ifFalse: [usersPurchases at: user put: LinkedList new].
	(usersPurchases at: user) add: purchase.! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 15:16:02'!
carts
	^carts.! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 17:19:24'!
checkUser: user password: pass
		((usersInfo at: user ifAbsent:[^self error: self class invalidUser]) = pass) 
		ifFalse: [^self error: self class invalidPassword].! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 17:41:19'!
deleteInvalidCart: cartID
	carts removeKey: cartID.
	usersCurrentCart removeKey: cartID.
	cartsLastUsedTime removeKey: cartID.
	
	self error: self class invalidCartID! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 17:42:34'!
getCart: anID
	|cart|
	cart := carts at: anID ifAbsent:[self error: self class invalidCartID].
	
	((cartsLastUsedTime at: anID) < 30) ifFalse:[self deleteInvalidCart: anID].
	
	"si es valido reseteo el tiempo"
	cartsLastUsedTime at: anID put: 0.
	
	^cart.! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/26/2017 21:00:27'!
nextCartID
	lastCartID := lastCartID + 1.
	^lastCartID.! !

!RestInterface methodsFor: 'private' stamp: 'fz 6/27/2017 17:32:47'!
thirtyMinutesLater
	|oldTime|
	cartsLastUsedTime keys do: [:cartID | 
		oldTime := cartsLastUsedTime at:cartID. 
		cartsLastUsedTime at: cartID put: oldTime + 30]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #'TusLibros-Solution'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'initialization' stamp: 'fz 6/27/2017 16:09:18'!
withCatalog: theCatalog withUsersInfo: theUsersInfo withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withCurrentDate: aDate 
	^self new withCatalog: theCatalog withUsersInfo: theUsersInfo withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withCurrentDate: aDate .! !


!RestInterface class methodsFor: 'messages' stamp: 'fz 6/27/2017 15:19:56'!
invalidCartID
	^'invalid cart ID'! !

!RestInterface class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:50:09'!
invalidPassword
	^'invalid password'.! !

!RestInterface class methodsFor: 'messages' stamp: 'fz 6/26/2017 20:50:00'!
invalidUser
	^'invalid user'.! !
