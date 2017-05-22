!classDefinition: #MedidaTest category: #Medidas!
TestCase subclass: #MedidaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas'!

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:38:50'!
test01sePuedeRepresentarUnMetro

	|unMetro|
	
	unMetro := Medida withValue: 1.
	
	^self assert: unMetro valor equals: 1.! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:40:29'!
test02unMetroEsIgualAUnMetro

	|unMetro otroUnMetro|
	
	unMetro := Medida withValue: 1.
	otroUnMetro := Medida withValue: 1.
	
	^self assert: (unMetro = otroUnMetro).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:47:16'!
test03unMetroNoEsIgualADosMetros

	|unMetro dosMetros|
	
	unMetro := Medida withValue: 1.
	dosMetros := Medida withValue: 2.
	
	^self deny: (unMetro = dosMetros).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:50:49'!
test04unMetroMasUnMetroIgualDosMetros

	|unMetro dosMetros|
	
	unMetro := Medida withValue: 1.
	dosMetros := Medida withValue: 2.
	
	^self assert: (unMetro + unMetro) equals: dosMetros.! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:03:45'!
test05sePuedeRepresentarUnCentimetroYNoEsUnMetro

	|unCentimetro unMetro|
	
	unCentimetro := Medida withValue: 1 wichIsInMeters: 1/100.
	unMetro := Medida withValue: 1.
	
	^self deny: (unCentimetro = unMetro).! !


!classDefinition: #Medida category: #Medidas!
Object subclass: #Medida
	instanceVariableNames: 'valor proporcion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas'!

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:53:59'!
+ aMedida 
	^ self class withValue: (self valor + aMedida valor).! !

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:13:53'!
= aMedida

	^(self valor * self proporcion) = (aMedida valor * aMedida proporcion).! !

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:48:11'!
initializeWithValue: aValue
	valor := aValue.! !

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:10:36'!
initializeWithValue: aValue andProportion: aProportion 
	valor := aValue.
	proporcion := aProportion.! !

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:12:57'!
proporcion
	^ proporcion.! !

!Medida methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 18:49:37'!
valor
	^valor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Medida class' category: #Medidas!
Medida class
	instanceVariableNames: ''!

!Medida class methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:18:16'!
withValue: aValue

	^ self new initializeWithValue: aValue andProportion: 1.! !

!Medida class methodsFor: 'as yet unclassified' stamp: 'fz 5/22/2017 19:09:47'!
withValue: aValue wichIsInMeters: aProportion
	^self new initializeWithValue: aValue andProportion: aProportion! !
