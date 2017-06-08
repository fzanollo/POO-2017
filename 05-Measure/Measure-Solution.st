!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'unKg otroKg dosKg milGramos kilogramos gramos litros unLitro unGramo mililitros milMl dosLitros diezPesos cincuentaDolares pesos dolares ceroKg ceroLitros ceroGramos celsius fahrenheit cincoCelsius cuarentaYUnFahrenheit dosMilGramos miligramos milMiligramos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:51:53'!
setUp
"Gramos"
	gramos := UnitBase withName:'Gramos'.
	kilogramos := UnitDerivedProportional withName:'Kilogramos' withBaseUnit: gramos withProportionToBase: 1000.
	miligramos := UnitDerivedProportional withName:'Miligramos' withBaseUnit: gramos withProportionToBase: 1/1000.
	
	ceroKg := Measure withAmount: 0 andUnit: kilogramos.
	unKg := Measure withAmount: 1 andUnit: kilogramos.
	otroKg := Measure withAmount: 1 andUnit: kilogramos.
	dosKg := Measure withAmount: 2 andUnit: kilogramos.
	
	milGramos := Measure withAmount: 1000 andUnit: gramos.
	dosMilGramos := Measure withAmount: 2000 andUnit: gramos.
	unGramo := Measure withAmount: 1 andUnit: gramos.
	
	milMiligramos := Measure withAmount: 1000 andUnit: miligramos.

"Litros"
	litros := UnitBase withName: 'Litros'.
	mililitros := UnitDerivedProportional withName: 'Mililitros' withBaseUnit: litros withProportionToBase: 1000.
	
	ceroLitros := Measure withAmount: 0 andUnit: litros.
	unLitro := Measure withAmount: 1 andUnit: litros.
	milMl := Measure withAmount: 1000 andUnit: mililitros.
	dosLitros := Measure withAmount: 2 andUnit: litros.
	
"Temperaturas"
	celsius := UnitBase withName: 'Celsius'.
	fahrenheit := UnitDerivedNoProportional withName: 'Fahrenheit' withBaseUnit: celsius withRelationToBase: [:anAmount | (anAmount - 32) * 5/9] withConvertion: [:anAmount | anAmount * 9/5 + 32].
	
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

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 18:37:14'!
test05sePuedeSumarMedidasDelMismoTipo
	self assert: unKg + milGramos equals: dosKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 18:37:05'!
test06sePuedeRestarMedidasDelMismoTipo
	self assert: dosKg - milGramos equals: unKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:24:54'!
test07sePuedeMultiplicarPorUnEscalar
	self assert: unLitro * 2 equals: dosLitros.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:30:49'!
test08sePuedeDividirPorUnEscalar
	self assert: dosLitros / 2 equals: unLitro.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:57:19'!
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

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:53:49'!
test15lasOperacionesAritmeticasDeMedidasSumanMedidasDelMismoTipo
	
	self assert: unKg + dosLitros + dosMilGramos equals: dosKg + dosLitros + milGramos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 18:44:28'!
test16sePuedenRestarMedidasDeDistintoTipo
	
	self assert: diezPesos - cincuentaDolares equals: -1*cincuentaDolares + diezPesos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:09:15'!
test17sePuedenRestarMedidasDeDistintoTipoAColeccionesDeMedidas
	
	self assert: diezPesos - cincuentaDolares - dosLitros equals: diezPesos - dosLitros - cincuentaDolares.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:54:00'!
test18lasOperacionesAritmeticasDeMedidasRestanMedidasDelMismoTipo
	
	self assert: dosMilGramos - unKg + dosLitros equals: dosKg + dosLitros - milGramos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:53:03'!
test19sePuedeConvertirUnaMedidaAOtraUnidadProporcionalDelMismoTipo
	
	self assert: (milGramos convertTo: kilogramos) equals: unKg.
	self assert: (milGramos convertTo: kilogramos) unit equals: kilogramos.
	
	self assert: (milMiligramos convertTo: gramos) equals: unGramo.
	self assert: (milMiligramos convertTo: gramos) unit equals: gramos.
	! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:48:18'!
test20sePuedeConvertirUnaMedidaAOtraUnidadNoProporcionalDelMismoTipo
	
	self assert: (cincoCelsius convertTo: fahrenheit) equals: cuarentaYUnFahrenheit .
	self assert: (cincoCelsius convertTo: fahrenheit) unit equals: fahrenheit.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:59:30'!
test21numeroPorUnidadCreaUnaMedida
	
	self assert: 2*kilogramos equals: dosKg.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:17:43'!
test22sePuedenDividirUnidades
	"10 metros/segundo"
	|diezMetrosSobreSegundo diezMetros unSegundo metros segundos metrosSobreSegundos|
	
	metros := UnitBase withName:'Metros'.
	segundos := UnitBase withName:'Segundos'.
	
	diezMetros := Measure withAmount: 10 andUnit: metros.
	unSegundo := Measure withAmount: 1 andUnit: segundos.
	
	metrosSobreSegundos := metros/segundos.
	diezMetrosSobreSegundo := Measure withAmount: 10 andUnit: metrosSobreSegundos.
	
	self assert: diezMetros / unSegundo equals: diezMetrosSobreSegundo.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:30:06'!
* aNumber
	^self class withAmount: (amount * aNumber) andUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 20:02:35'!
+ aMeasure 
	self ifSameBaseUnit: aMeasure do: [^self class withAmount: (self amountInBaseUnit + aMeasure amountInBaseUnit) andUnit: unit baseUnit].
	
	^ MeasureArithmeticOperations with: self with: aMeasure.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 20:02:27'!
- aMeasure 
	self ifSameBaseUnit: aMeasure do: [^ self class withAmount: (self amountInBaseUnit - aMeasure amountInBaseUnit) andUnit: unit baseUnit].
	
	^ MeasureArithmeticOperations with: self withNegative: aMeasure.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:24:53'!
/ aNumber
	(aNumber isKindOf: Number) ifTrue: [^self class withAmount: (amount / aNumber) andUnit: unit].
	
	^self class withAmount: (amount / aNumber amount) andUnit: (UnitBase withName: 'MetrosSobreSegundos').! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 20:02:12'!
= aMeasure
	self ifSameBaseUnit: aMeasure do: [^ self amountInBaseUnit = aMeasure amountInBaseUnit].
	^ (amount = 0) and: [aMeasure amount = 0]! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:58:26'!
adaptToNumber: aNumber andSend: selector
	^ self perform: selector with: aNumber.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 18:59:21'!
additiveInverse

	^self class withAmount: -1*self amount andUnit: self unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:55:00'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 20:42:08'!
amountInBaseUnit
	^unit convertToBaseUnit: amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:45:46'!
convertTo: aUnit
	^self class withAmount: (aUnit convertToThisUnitFromBase: self amountInBaseUnit) andUnit: aUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:03:17'!
ifSameBaseUnit: aMeasure do: instructions
	(unit baseUnit = (aMeasure unit) baseUnit) ifTrue: instructions.! !

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

!Measure class methodsFor: 'as yet unclassified' stamp: 'fz 6/1/2017 19:59:11'!
withAmount: anAmount andUnit: aUnit
	^self new initializeWithAmount: anAmount andUnit: aUnit.! !


!classDefinition: #MeasureArithmeticOperations category: #'Measure-Solution'!
Object subclass: #MeasureArithmeticOperations
	instanceVariableNames: 'measuresDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureArithmeticOperations methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:12:09'!
+ aMeasure 
	self add: aMeasure! !

!MeasureArithmeticOperations methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:14:07'!
- aMeasure 
	self add: aMeasure additiveInverse.! !

!MeasureArithmeticOperations methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:15:20'!
= aMeasureCollection

	^measuresDictionary = aMeasureCollection measuresDictionary.! !

!MeasureArithmeticOperations methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:16:05'!
measuresDictionary
	^measuresDictionary.! !

!MeasureArithmeticOperations methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:13:31'!
with: aMeasure with: anotherMeasure
	measuresDictionary := Dictionary new.
	
	measuresDictionary add: (Association key: aMeasure unit baseUnit value: aMeasure).
	measuresDictionary add: (Association key: anotherMeasure unit baseUnit value: anotherMeasure).! !


!MeasureArithmeticOperations methodsFor: 'private' stamp: 'fz 6/7/2017 19:11:49'!
add: aMeasure
	|savedMeasure|
	
	savedMeasure := measuresDictionary at: aMeasure unit baseUnit ifAbsent: [ Measure withAmount: 0 andUnit: aMeasure unit].
	
	measuresDictionary add: (Association key: aMeasure unit baseUnit value: aMeasure + savedMeasure).










! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureArithmeticOperations class' category: #'Measure-Solution'!
MeasureArithmeticOperations class
	instanceVariableNames: ''!

!MeasureArithmeticOperations class methodsFor: 'as yet unclassified' stamp: 'fz 6/6/2017 20:10:46'!
with: aMeasure with: anotherMeasure
	^self new with: aMeasure with: anotherMeasure.! !

!MeasureArithmeticOperations class methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 19:00:09'!
with: aMeasure withNegative: anotherMeasure
	^ self with: aMeasure with: anotherMeasure additiveInverse.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:19:16'!
/ aUnit
	^ UnitBase withName: 'MetrosSobreSegundos'.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:29:42'!
= aUnit
	^ name = (aUnit name)! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:13:09'!
adaptToNumber: aNumber andSend: selector
	^ self createMeasure: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:06:36'!
baseUnit
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:15:08'!
convertToBaseUnit: anAmount
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:46:00'!
convertToThisUnitFromBase: anAmount
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:12:13'!
createMeasure: aNumber
	^ Measure withAmount: aNumber andUnit: self.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:31:23'!
name
	^name.! !


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

!UnitBase methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:45:53'!
convertToThisUnitFromBase: anAmount
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
	instanceVariableNames: 'baseUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitDerived methodsFor: 'as yet unclassified' stamp: 'fz 6/5/2017 18:07:24'!
baseUnit
	^baseUnit.! !


!classDefinition: #UnitDerivedNoProportional category: #'Measure-Solution'!
UnitDerived subclass: #UnitDerivedNoProportional
	instanceVariableNames: 'relationToBase convertionToThisUnitFromBaseUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitDerivedNoProportional methodsFor: 'initialization' stamp: 'fz 6/7/2017 21:37:40'!
withName: aName withBaseUnit: aBaseUnit withRelationToBase: aRelationToBase withConvertion: aConvertionToThisUnit
	name := aName.
	baseUnit := aBaseUnit.
	relationToBase := aRelationToBase.
	convertionToThisUnitFromBaseUnit := aConvertionToThisUnit.! !


!UnitDerivedNoProportional methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:30:21'!
convertToBaseUnit: anAmount
	^ relationToBase value: anAmount.! !

!UnitDerivedNoProportional methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:48:55'!
convertToThisUnitFromBase: anAmount 
	^convertionToThisUnitFromBaseUnit value: anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitDerivedNoProportional class' category: #'Measure-Solution'!
UnitDerivedNoProportional class
	instanceVariableNames: ''!

!UnitDerivedNoProportional class methodsFor: 'initialization' stamp: 'fz 6/7/2017 21:26:38'!
withName: aName withBaseUnit: aBaseUnit withRelationToBase: aRelationToBase withConvertion: aConvertionToThisUnit
	^self new withName: aName withBaseUnit: aBaseUnit withRelationToBase: aRelationToBase withConvertion: aConvertionToThisUnit.! !


!classDefinition: #UnitDerivedProportional category: #'Measure-Solution'!
UnitDerived subclass: #UnitDerivedProportional
	instanceVariableNames: 'proportion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitDerivedProportional methodsFor: 'initialization' stamp: 'fz 6/7/2017 21:25:19'!
withName: aName withBaseUnit: aBaseUnit withProportionToBase: aProportion
	name := aName.
	baseUnit := aBaseUnit.
	proportion := aProportion.! !


!UnitDerivedProportional methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:30:46'!
convertToBaseUnit: anAmount
	^ anAmount * proportion.! !

!UnitDerivedProportional methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 21:46:10'!
convertToThisUnitFromBase: anAmount
	^ anAmount / proportion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitDerivedProportional class' category: #'Measure-Solution'!
UnitDerivedProportional class
	instanceVariableNames: ''!

!UnitDerivedProportional class methodsFor: 'initialization' stamp: 'fz 6/7/2017 21:23:31'!
withName: aName withBaseUnit: baseUnit withProportionToBase: aProportion
	^self new withName: aName withBaseUnit: baseUnit withProportionToBase: aProportion.! !
