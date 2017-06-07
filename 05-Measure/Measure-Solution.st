!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'unKg otroKg dosKg milGramos kilogramos gramos litros unLitro unGramo mililitros milMl dosLitros diezPesos cincuentaDolares pesos dolares ceroKg ceroLitros ceroGramos celsius fahrenheit cincoCelsius cuarentaYUnFahrenheit dosMilGramos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:21:18'!
setUp
"Gramos"
	gramos := UnitBase withName:'Gramos'.
	kilogramos := UnitDerived withName:'Kilogramos' withBaseUnit: gramos withRelationToBase: [:anAmount | anAmount*1000].
	
	ceroKg := Measure withAmount: 0 andUnit: kilogramos.
	unKg := Measure withAmount: 1 andUnit: kilogramos.
	otroKg := Measure withAmount: 1 andUnit: kilogramos.
	dosKg := Measure withAmount: 2 andUnit: kilogramos.
	
	milGramos := Measure withAmount: 1000 andUnit: gramos.
	dosMilGramos := Measure withAmount: 2000 andUnit: gramos.
	unGramo := Measure withAmount: 1 andUnit: gramos.

"Litros"
	litros := UnitBase withName: 'Litros'.
	mililitros := UnitDerived withName: 'Mililitros' withBaseUnit: litros withRelationToBase: [:anAmount | anAmount *1000].
	
	ceroLitros := Measure withAmount: 0 andUnit: litros.
	unLitro := Measure withAmount: 1 andUnit: litros.
	milMl := Measure withAmount: 1000 andUnit: mililitros.
	dosLitros := Measure withAmount: 2 andUnit: litros.
	
"Temperaturas"
	celsius := UnitBase withName: 'Celsius'.
	fahrenheit := UnitDerived withName: 'Fahrenheit' withBaseUnit: celsius withRelationToBase: [:anAmount | (anAmount - 32) * 5/9].
	
	cincoCelsius  := Measure withAmount: 5 andUnit: celsius.
	cuarentaYUnFahrenheit := Measure withAmount: 41 andUnit: fahrenheit.

"Monedas"
	pesos := UnitBase withName: 'Pesos'.
	dolares := UnitBase withName: 'Dolares'.
	
	diezPesos := Measure withAmount: 10 andUnit: pesos.
	cincuentaDolares := Measure withAmount: 50 andUnit: dolares.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:11:46'!
test01medidasDeLaMismaCantidadYUnidadSonIguales

	self assert: unKg = otroKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:11:26'!
test02medidasDeDistintaCantidadDeLaMismaUnidadSonDistintas
	self deny: unKg = dosKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:11:00'!
test03unaMedidaYUnaCantidadEquivalenteEnOtraUnidadSonIguales
	self assert: unKg = milGramos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:12:04'!
test04medidasDeDistintasUnidadesSonDistintas
	self deny: unGramo = unLitro.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:23:23'!
test05sePuedeSumarMedidasDelMismoTipoDeUnidad
	self assert: unKg + milGramos equals: dosKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 19:23:48'!
test06sePuedeRestarMedidasDelMismoTipoDeUnidad
	self assert: dosKg - milGramos equals: unKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:24:54'!
test07sePuedeMultiplicarPorUnEscalar
	self assert: unLitro * 2 equals: dosLitros.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:30:49'!
test08sePuedeDividirPorUnEscalar
	self assert: dosLitros / 2 equals: unLitro.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:33:09'!
test09sePuedeMultiplicarUnEscalarPorUnaMedida
	self assert: 2 * unLitro equals: dosLitros.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 20:25:08'!
test10compararMedidasDeDistintoTipoDaFalsoNoError
	"agregamos el test por completitud, pasó directamente por cómo implementamos =, en vez de poner ifTrue, usamos un and"
	self deny: unKg = dosLitros.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 20:32:13'!
test11nadaEsIgualANadaDeDistintoTipo
	
	self assert: ceroKg = ceroLitros.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 20:53:28'!
test12laRelacionConLaUnidadBasePuedeSerCualquierCombinacionDeOperandos
	
	self assert: cincoCelsius  equals: cuarentaYUnFahrenheit.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 19:45:21'!
test13sePuedenSumarMedidasDeDistintoTipo
	"10 pesos + 50 dolares = 10 pesos + 50 dolares"
	
	self assert: diezPesos + cincuentaDolares equals: cincuentaDolares + diezPesos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:18:40'!
test14sePuedenSumarMedidasDeDistintoTipoAColeccionesDeMedidas
	
	self assert: diezPesos + cincuentaDolares + dosLitros equals: cincuentaDolares + dosLitros + diezPesos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:49:37'!
test15coleccionesDeMedidasSumanMedidasDelMismoTipo
	
	self assert: unKg + dosLitros + dosMilGramos equals: dosKg + dosLitros + milGramos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:51:31'!
test16sePuedenRestarMedidasDeDistintoTipo
	
	self assert: dosKg - cincuentaDolares equals: cincuentaDolares - dosKg.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:30:06'!
* aNumber
	^self class withAmount: (amount * aNumber) andUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:09:44'!
+ aMeasure 
	(unit baseUnit = aMeasure unit baseUnit) ifTrue: [^self class withAmount: (self amountInBaseUnit + aMeasure amountInBaseUnit) andUnit: unit baseUnit].
	
	^ MeasureCollection with: self with: aMeasure.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:23:21'!
- aMeasure 
	^ self class withAmount: (self amountInBaseUnit - aMeasure amountInBaseUnit) andUnit: unit baseUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:31:26'!
/ aNumber
	^self class withAmount: (amount / aNumber) andUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 20:29:39'!
= aMeasure
	(unit baseUnit = (aMeasure unit) baseUnit) ifTrue: [^ self amountInBaseUnit = aMeasure amountInBaseUnit]
													 ifFalse: [^ (amount = 0) and: [aMeasure amount = 0]].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:34:05'!
adaptToNumber: aNumber andSend: selector
	^ self perform: selector with: aNumber.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:55:00'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 20:42:08'!
amountInBaseUnit
	^unit convertToBaseUnit: amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:54:18'!
initializeWithAmount: anAmount
	amount := anAmount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:59:39'!
initializeWithAmount: anAmount andUnit: aUnit
	amount := anAmount.
	unit := aUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 20:00:43'!
unit
	^unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:53:57'!
withAmount: anAmount
	^self new initializeWithAmount: anAmount.! !

!Measure class methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:59:11'!
withAmount: anAmount andUnit: aUnit
	^self new initializeWithAmount: anAmount andUnit: aUnit.! !


!classDefinition: #MeasureCollection category: #'Measure-Solution'!
Object subclass: #MeasureCollection
	instanceVariableNames: 'measuresDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureCollection methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:46:21'!
+ aMeasure 
	|anotherMeasure|
	
	anotherMeasure := measuresDictionary at: aMeasure unit baseUnit ifAbsent: [ Measure withAmount: 0 andUnit: aMeasure unit].
	
	measuresDictionary add: (Association key: aMeasure unit baseUnit value: aMeasure + anotherMeasure).! !

!MeasureCollection methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:15:20'!
= aMeasureCollection

	^measuresDictionary = aMeasureCollection measuresDictionary.! !

!MeasureCollection methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:16:05'!
measuresDictionary
	^measuresDictionary.! !

!MeasureCollection methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:13:31'!
with: aMeasure with: anotherMeasure
	measuresDictionary := Dictionary new.
	
	measuresDictionary add: (Association key: aMeasure unit baseUnit value: aMeasure).
	measuresDictionary add: (Association key: anotherMeasure unit baseUnit value: anotherMeasure).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureCollection class' category: #'Measure-Solution'!
MeasureCollection class
	instanceVariableNames: ''!

!MeasureCollection class methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:10:46'!
with: aMeasure with: anotherMeasure
	^self new with: aMeasure with: anotherMeasure.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:06:36'!
baseUnit
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:15:08'!
convertToBaseUnit: anAmount
	self subclassResponsibility! !


!classDefinition: #UnitBase category: #'Measure-Solution'!
Unit subclass: #UnitBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitBase methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:07:05'!
baseUnit
	^self.! !

!UnitBase methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:14:05'!
convertToBaseUnit: anAmount
	^anAmount.! !

!UnitBase methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:07:49'!
initializeWithName: aName
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitBase class' category: #'Measure-Solution'!
UnitBase class
	instanceVariableNames: ''!

!UnitBase class methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:05:16'!
withName: aName
	^self new initializeWithName: aName.! !


!classDefinition: #UnitDerived category: #'Measure-Solution'!
Unit subclass: #UnitDerived
	instanceVariableNames: 'proportion baseUnit relationWithBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitDerived methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:07:24'!
baseUnit
	^baseUnit.! !

!UnitDerived methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 20:51:39'!
convertToBaseUnit: anAmount
	^relationWithBase value: anAmount.! !

!UnitDerived methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:10:04'!
initializeWithName: aName andBaseUnit: aBaseUnit andRelationToBase: theRelationWithBaseUnit
	name := aName.
	baseUnit := aBaseUnit.
	relationWithBase := theRelationWithBaseUnit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitDerived class' category: #'Measure-Solution'!
UnitDerived class
	instanceVariableNames: ''!

!UnitDerived class methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:09:12'!
withName: aName withBaseUnit: aBaseUnit withRelationToBase: theRelationWithBaseUnit
	^self new initializeWithName: aName andBaseUnit: aBaseUnit andRelationToBase: theRelationWithBaseUnit.! !
