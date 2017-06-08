!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'unKg otroKg dosKg milGramos kilogramos gramos litros unLitro unGramo mililitros milMl dosLitros diezPesos cincuentaDolares pesos dolares ceroKg ceroLitros ceroGramos celsius fahrenheit cincoCelsius cuarentaYUnFahrenheit dosMilGramos miligramos milMiligramos diezMetros unSegundo diezMetrosSobreSegundo metros segundos metrosSobreSegundos metrosCuadrados cienMetrosCuadrados metrosCubicos milMetrosCubicos dosMetrosSobreSegundo metros2SobreSeg2 veinteMetros2SobreSeg2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 18:00:38'!
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
	cincuentaDolares := Measure withAmount: 50 andUnit: dolares.

"Unidades compuestas"
	metros := UnitBase withName:'Metros'.
	segundos := UnitBase withName:'Segundos'.
	
	diezMetros := Measure withAmount: 10 andUnit: metros.
	unSegundo := Measure withAmount: 1 andUnit: segundos.
	
	metrosSobreSegundos := metros/segundos.
	diezMetrosSobreSegundo := Measure withAmount: 10 andUnit: metrosSobreSegundos.
	dosMetrosSobreSegundo := Measure withAmount: 2 andUnit: metrosSobreSegundos.
	
	metros2SobreSeg2 := (metros/segundos) * (metros/segundos).
	veinteMetros2SobreSeg2 := Measure withAmount: 20 andUnit: metros2SobreSeg2.
	
	metrosCuadrados := metros * metros.
	cienMetrosCuadrados := Measure withAmount: 100 andUnit: metrosCuadrados.
	
	metrosCubicos := metrosCuadrados * metros.
	milMetrosCubicos := Measure withAmount: 1000 andUnit: metrosCubicos.
! !

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

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:27:06'!
test22sePuedenDividirUnidades
	self assert: diezMetros / unSegundo equals: diezMetrosSobreSegundo.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:36:48'!
test23sePuedenMultiplicarUnidades	
	self assert: diezMetros * diezMetros equals: cienMetrosCuadrados .! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:56:57'!
test24sePuedeMultiplicarUnaUnidadesCompuestaPorUnaUnidad
	self assert: cienMetrosCuadrados * diezMetros equals: milMetrosCubicos.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 18:01:04'!
test25sePuedenMultiplicarUnidadesCompuestas
	self assert: diezMetrosSobreSegundo * dosMetrosSobreSegundo equals: veinteMetros2SobreSeg2 ! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:38:44'!
* aMultiplier
	(aMultiplier isKindOf: Number) ifTrue: [^self class withAmount: (amount * aMultiplier) andUnit: unit].
	
	^Measure withAmount: amount * aMultiplier amount andUnit: unit * aMultiplier unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 16:54:06'!
+ aMeasure 
	((self unit) sameBaseUnit: (aMeasure unit)) ifTrue:[^self class withAmount: (self amountInBaseUnit + aMeasure amountInBaseUnit) andUnit: unit baseUnit].
	
	^ MeasureArithmeticOperations with: self with: aMeasure.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 16:16:06'!
- aMeasure 
	(self unit sameBaseUnit: aMeasure unit) ifTrue:[^ self class withAmount: (self amountInBaseUnit - aMeasure amountInBaseUnit) andUnit: unit baseUnit].
	
	^ MeasureArithmeticOperations with: self withNegative: aMeasure.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:03:33'!
/ aDivisor
	(aDivisor isKindOf: Number) ifTrue: [^self class withAmount: (amount / aDivisor) andUnit: unit].
	
	^ Measure withAmount: amount / aDivisor amount andUnit: unit / aDivisor unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 16:06:34'!
= aMeasure
	(self unit sameBaseUnit: aMeasure unit) ifTrue:[^ self amountInBaseUnit = aMeasure amountInBaseUnit].
	
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


!MeasureArithmeticOperations methodsFor: 'private' stamp: 'fz 6/8/2017 16:25:52'!
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


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: 'meter celsius second'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:17:37'!
centimeter
	^UnitDerivedProportional withName:'centimeter' withBaseUnit: meter withProportionToBase: 1/100.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:17:14'!
decameter
	^UnitDerivedProportional withName:'decameter' withBaseUnit: meter withProportionToBase: 10.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:16:57'!
decimeter
	^UnitDerivedProportional withName:'decimeter' withBaseUnit: meter withProportionToBase: 1/10.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:16:02'!
hectometer
	^UnitDerivedProportional withName:'hectometer' withBaseUnit: meter withProportionToBase: 100.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:15:09'!
kilometer
	^UnitDerivedProportional withName:'kilometer' withBaseUnit: meter withProportionToBase: 1000.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:19:44'!
meter
	^meter.! !

!MeasureFactory methodsFor: 'distance units' stamp: 'fz 6/8/2017 18:15:33'!
milimeter
	^UnitDerivedProportional withName:'milimeter' withBaseUnit: meter withProportionToBase: 1/1000.! !


!MeasureFactory methodsFor: 'initialize' stamp: 'fz 6/8/2017 18:26:19'!
initialize
"unidades bases"
	meter := UnitBase withName:'meter'.
	
	celsius := UnitBase withName: 'celsius'.
	
	second := UnitBase withName: 'seconds'.
! !


!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:18:57'!
minusOneMeter
	^Measure withAmount: -1 andUnit: meter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:19:13'!
oneCentimeter
	^Measure withAmount: 1 andUnit: self centimeter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:19:22'!
oneHundredCentimeters
	^Measure withAmount: 100 andUnit: self centimeter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:19:35'!
oneMeter
	^Measure withAmount: 1 andUnit: meter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:20:00'!
twoHundredCentimeters
	^Measure withAmount: 200 andUnit: self centimeter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:20:12'!
twoMeters
	^Measure withAmount: 2 andUnit: meter.! !

!MeasureFactory methodsFor: 'distance measures' stamp: 'fz 6/8/2017 18:20:20'!
zeroMeters
	^Measure withAmount: 0 andUnit: meter.! !


!MeasureFactory methodsFor: 'temperature units' stamp: 'fz 6/8/2017 18:21:15'!
celsius
	^celsius.! !

!MeasureFactory methodsFor: 'temperature units' stamp: 'fz 6/8/2017 18:21:48'!
fahrenheit
	^UnitDerivedNoProportional withName: 'fahrenheit' withBaseUnit: celsius withRelationToBase: [:anAmount | (anAmount - 32) * 5/9] withConvertion: [:anAmount | anAmount * 9/5 + 32].! !

!MeasureFactory methodsFor: 'temperature units' stamp: 'fz 6/8/2017 18:23:19'!
kelvin
	^UnitDerivedNoProportional withName: 'kelvin' withBaseUnit: celsius withRelationToBase: [:anAmount | anAmount -273.15] withConvertion: [:anAmount | anAmount + 273.15].! !


!MeasureFactory methodsFor: 'temperature measures' stamp: 'fz 6/8/2017 18:24:05'!
oneCelsius
	^Measure withAmount: 1 andUnit: celsius.! !

!MeasureFactory methodsFor: 'temperature measures' stamp: 'fz 6/8/2017 18:24:19'!
thirtyTwoFahrenheits
	^Measure withAmount: 32 andUnit: self fahrenheit.! !

!MeasureFactory methodsFor: 'temperature measures' stamp: 'fz 6/8/2017 18:25:14'!
twoCelsius
	^Measure withAmount: 2 andUnit: celsius.! !

!MeasureFactory methodsFor: 'temperature measures' stamp: 'fz 6/8/2017 18:25:25'!
zeroCelsius
	^Measure withAmount: 0 andUnit: celsius.! !

!MeasureFactory methodsFor: 'temperature measures' stamp: 'fz 6/8/2017 18:25:40'!
zeroKelvin
	^Measure withAmount: 0 andUnit: self kelvin.! !


!MeasureFactory methodsFor: 'time units' stamp: 'fz 6/8/2017 18:29:44'!
day
	^UnitDerivedProportional withName:'day' withBaseUnit: second withProportionToBase: 86400.! !

!MeasureFactory methodsFor: 'time units' stamp: 'fz 6/8/2017 18:29:05'!
hour
	^UnitDerivedProportional withName:'hour' withBaseUnit: second withProportionToBase: 3600.! !

!MeasureFactory methodsFor: 'time units' stamp: 'fz 6/8/2017 18:28:49'!
minute
	^UnitDerivedProportional withName:'minute' withBaseUnit: second withProportionToBase: 60.! !

!MeasureFactory methodsFor: 'time units' stamp: 'fz 6/8/2017 18:30:19'!
second
	^second.! !


!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:30:47'!
oneDay
	^Measure withAmount: 1 andUnit: self day.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:30:55'!
oneHour
	^Measure withAmount: 1 andUnit: self hour.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:31:03'!
oneMinute
	^Measure withAmount: 1 andUnit: self minute.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:31:50'!
oneSecond
	^Measure withAmount: 1 andUnit: second.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:31:26'!
sixtyMinutes
	^Measure withAmount: 60 andUnit: self minutes.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:31:46'!
sixtyOneSeconds
	^Measure withAmount: 61 andUnit: second.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:32:05'!
sixtySeconds
	^Measure withAmount: 60 andUnit: second.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:32:32'!
twentyFourHours
	^Measure withAmount: 24 andUnit: self hour.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:32:47'!
twoSeconds
	^Measure withAmount: 2 andUnit: second.! !

!MeasureFactory methodsFor: 'time measures' stamp: 'fz 6/8/2017 18:32:56'!
zeroSeconds
	^Measure withAmount: 0 andUnit: second.! !


!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:34:06'!
eightCubicMeters
	^Measure withAmount: 8 andUnit: (meter * meter * meter).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:34:18'!
fourSquaredMeters
	^Measure withAmount: 4 andUnit: (meter * meter).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:34:36'!
oneHundredTwentyOneMetersPerSecond
	^Measure withAmount: 121 andUnit: (meter / second).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:34:48'!
oneMeterPerSecond
	^Measure withAmount: 1 andUnit: (meter / second).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:35:00'!
oneSquaredMeter
	^Measure withAmount: 1 andUnit: (meter * meter).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:35:11'!
oneSquaredSecond
	^Measure withAmount: 1 andUnit: (second * second).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:36:03'!
twoMetersBySecond
	^Measure withAmount: 2 andUnit: (meter / second).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:36:22'!
twoMetersPerSquaredSecond
	^Measure withAmount: 2 andUnit: (meter / (second * second)).! !

!MeasureFactory methodsFor: 'compound measures' stamp: 'fz 6/8/2017 18:36:48'!
twoMetersTimesSecond
	^Measure withAmount: 2 andUnit: meter * second.! !


!MeasureFactory methodsFor: 'formula' stamp: 'fz 6/8/2017 18:38:10'!
finalSpeedStartingAt: start accelerating: aceleration during: time 
"que debe implementar la formula de velocidad final: vf = vi + a * t "

	^ start + (aceleration * time).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 18:13:32'!
initialize
	^self new initialize.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:32:29'!
* anUnitBase 
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 15:42:23'!
/ aUnit
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:13:09'!
adaptToNumber: aNumber andSend: selector
	^ self createMeasure: aNumber.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 15:54:24'!
baseUnit
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:18:47'!
convertToBaseUnit: anAmount
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:24:45'!
convertToThisUnitFromBase: anAmount
	self subclassResponsibility! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 15:52:29'!
createMeasure: aNumber
	^ Measure withAmount: aNumber andUnit: self.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/7/2017 22:31:23'!
name
	^name.! !

!Unit methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 16:57:02'!
sameBaseUnit: aUnit
	self subclassResponsibility! !


!classDefinition: #UnitCompound category: #'Measure-Solution'!
Unit subclass: #UnitCompound
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 18:11:26'!
* aUnit
	|newNumerator |
		newNumerator := numerator copy.
		newNumerator add: aUnit.
		^ UnitCompound withNumerator: newNumerator withDenominator: denominator .! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:17:20'!
= aUnit
	(aUnit isKindOf: self class) ifTrue:[^ (numerator = aUnit numerator) and: [denominator = aUnit denominator]].
	
	^false.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:51:56'!
baseUnit
	|numeratorBases denominatorBases|
	
	numeratorBases := OrderedCollection new.
	denominatorBases := OrderedCollection new.
	
	numerator do: [:aUnit | numeratorBases add: aUnit baseUnit].

	denominator do: [:aUnit | denominatorBases add: aUnit baseUnit].

	^ UnitCompound withNumeratorUnit: numeratorBases withDenominatorUnit: denominatorBases.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:29:27'!
convertToBaseUnit: anAmount
	|partialResult|
	
	partialResult := anAmount.
	
	numerator do: [:aUnit | partialResult := aUnit convertToBaseUnit: partialResult].
	
	denominator do: [:aUnit | partialResult := aUnit convertToThisUnitFromBase: partialResult].
	
	^partialResult.
	
! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:17:52'!
denominator
	^denominator.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:17:38'!
numerator
	^numerator.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:08:47'!
sameBaseUnit: aUnit
	^self baseUnit = aUnit baseUnit.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:53:45'!
withNumerator: aNumerator withDenominator: aDenominator
	numerator := aNumerator.
	denominator := aDenominator.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:54:37'!
withNumeratorUnit: aUnit andAnotherNumeratorUnit: anotherUnit
	numerator := OrderedCollection with: aUnit with:anotherUnit .
	denominator := OrderedCollection new.! !

!UnitCompound methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:52:40'!
withNumeratorUnit: aUnit withDenominatorUnit: anotherUnit
	numerator := OrderedCollection with: aUnit.
	denominator := OrderedCollection with: anotherUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitCompound class' category: #'Measure-Solution'!
UnitCompound class
	instanceVariableNames: ''!

!UnitCompound class methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:53:28'!
withNumerator: aNumerator withDenominator: aDenominator
	^self new withNumerator: aNumerator withDenominator: aDenominator .! !

!UnitCompound class methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:54:28'!
withNumeratorUnit: aUnit andAnotherNumeratorUnit: anotherUnit
	^self new withNumeratorUnit: aUnit andAnotherNumeratorUnit: anotherUnit.! !

!UnitCompound class methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:52:25'!
withNumeratorUnit: aUnit withDenominatorUnit: anotherUnit
	^self new withNumeratorUnit: aUnit withDenominatorUnit: anotherUnit.! !


!classDefinition: #UnitSimple category: #'Measure-Solution'!
Unit subclass: #UnitSimple
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!UnitSimple methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:54:10'!
* aUnit
	^ UnitCompound withNumeratorUnit: self andAnotherNumeratorUnit: aUnit.! !

!UnitSimple methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:52:17'!
/ aUnit
	^ UnitCompound withNumeratorUnit: self withDenominatorUnit: aUnit.! !

!UnitSimple methodsFor: 'as yet unclassified' stamp: 'fz 6/8/2017 17:25:13'!
sameBaseUnit: aUnit
	^self baseUnit = aUnit baseUnit.! !


!classDefinition: #UnitBase category: #'Measure-Solution'!
UnitSimple subclass: #UnitBase
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
UnitSimple subclass: #UnitDerived
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

MeasureFactory initialize!