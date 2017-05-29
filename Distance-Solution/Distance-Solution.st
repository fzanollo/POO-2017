!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro dosMetros cienCentimetros milMilimetros diezKilometros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:24:42'!
test01sePuedeRepresentarUnMetro
	
	^self assert: unMetro valor equals: 1.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:27'!
test02unMetroEsIgualAUnMetro
"creamos otroUnMetro para que falle porque usaba el igual de objetos y pasaba"
	|otroUnMetro|
	
	otroUnMetro := Distance withValueInMeters: 1.
	
	^self assert: (unMetro = otroUnMetro).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:36'!
test03sePuedeRepresentarDosMetros
	
	^self assert: dosMetros valor equals: 2.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:41'!
test04unMetroNoEsIgualADosMetros
	
	^self deny: (unMetro = dosMetros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:45'!
test05unMetroMasUnMetroIgualDosMetros
	
	^self assert: (unMetro + unMetro) equals: dosMetros.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:51'!
test06unMetroEsIgualACienCentimetros

	^self assert: (unMetro = cienCentimetros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:25:56'!
test07cienCentimetrosEsIgualAMilMilimetros

	^self assert: (cienCentimetros = milMilimetros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:26:03'!
test08milMmMasCienCmEsIgualADosMetros
"milMilimetros + cienCentimetros = dosMetros"
	
	^self assert: (milMilimetros + cienCentimetros) equals: dosMetros.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:26:12'!
test09dosMetrosMenosCienCmEsIgualAMilMm
"dosMetros - cienCentimetros = milMilimetros"
	
	^self assert: (dosMetros - cienCentimetros) equals: milMilimetros.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:29:08'!
test10unMetroPorDosEsIgualADosMetros

	self assert: (unMetro * 2) equals: dosMetros.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 15:34:32'!
test11dosPorUnMetroEsIgualADosMetros

	self assert: (2 * unMetro) equals: dosMetros.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:28:56'!
test12UnMetroDivididoDosEsIgualAMedioMetro
	
	|medioMetro|
	
	medioMetro := Distance withValueInMeters: 1/2.

	self assert: ( unMetro / 2) equals: medioMetro.! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:46:29'!
test13diezKmEsMayorEstrictoQueUnMetro
	
	self assert: (diezKilometros > unMetro).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:46:52'!
test14unMetroNoEsMayorEstrictoQueDiezKm
	
	self deny: ( unMetro > diezKilometros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:47:05'!
test15unMetroEsMenorEstrictoQueDiezKm
	
	self assert: ( unMetro < diezKilometros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:47:16'!
test16diezKmNoEsMenorEstrictoQueUnMetro
	
	self deny: ( diezKilometros < unMetro).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:48:05'!
test17unMetroEsMenorIgualQueDiezKm
	
	self assert: ( unMetro <= diezKilometros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:49:24'!
test18diezKmNoEsMenorIgualQueUnMetro
	
	self deny: ( diezKilometros <= unMetro).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:50:52'!
test19diezKmEsMayorIgualQueUnMetro
	
	self assert: (diezKilometros >= unMetro).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:53:08'!
test20unMetroNoEsMayorIgualQueDiezKm
	
	self deny: ( unMetro >= diezKilometros).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 16:59:14'!
test21unMetroATresMetrosEsUnIntervaloConPasosDeUnMetro
"unMetro to: tresMetros  <-- representa un intervalo que va desde un metro a tres metros con pasos de un metro"
	|tresMetros|
	
	tresMetros := Distance withValueInMeters: 3.
	
	self assert: ( unMetro to: tresMetros) equals: (1 to: 3).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 17:47:28'!
test22unMetroADiezKmPorCincoCmEsUnIntervaloConPasosDeCincoCm
"unMetro to: diezKilometros by: cincoCentimetros <-- representa un intervalo que va de un metro a diez kilometors cada cinco centimetros"
	|cincoCentimetros|
	
	cincoCentimetros  := Distance withValue: 5 andMagnitudeInMeters: 1/100.
	
	self assert: ( unMetro to: diezKilometros by: cincoCentimetros) equals: (1 to: 10000 by: 5/100).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 17:47:32'!
test23alIntervaloUnMetroADiezKmPorCincoCmSeLePuedePasarUnaTareaARealizar
"unMetro to: diezKilometros by: cincoCentimetros do:[...] <-- permite recorrer el intervalo "

	|cincoCentimetros distanceIntervalCounter numberIntervalCounter|
	
	cincoCentimetros  := Distance withValue: 5 andMagnitudeInMeters: 1/100.
	
	distanceIntervalCounter := 0.
	numberIntervalCounter := 0.
	
	self assert: ( unMetro to: diezKilometros by: cincoCentimetros do:[:i|distanceIntervalCounter := distanceIntervalCounter + 1]) equals: 
	(1 to: 10000 by: 5/100 do:[:i|numberIntervalCounter := numberIntervalCounter + 1]).! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 18:11:14'!
test24noSePuedenCrearDistanciasNegativasEnMetros

	self should: [Distance withValueInMeters: -1]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText equals: Distance negativeDistanceMessage].! !

!DistanceTest methodsFor: 'tests' stamp: 'fz 5/29/2017 18:15:01'!
test25noSePuedenCrearDistanciasNegativasEnCentimetros
"ni en ninguna otra unidad"

	self should: [Distance withValue: -1 andMagnitudeInMeters: 1/100]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText equals: Distance negativeDistanceMessage]! !


!DistanceTest methodsFor: 'setUp' stamp: 'fz 5/29/2017 17:47:22'!
setUp
	unMetro := Distance withValueInMeters: 1.
	dosMetros := Distance withValueInMeters: 2.
	cienCentimetros := Distance withValue: 100 andMagnitudeInMeters: 1/100.
	milMilimetros := Distance withValue: 1000 andMagnitudeInMeters: 1/1000.
	diezKilometros := Distance withValue: 10 andMagnitudeInMeters: 1000.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'valor proporcion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'intervals' stamp: 'fz 5/29/2017 17:32:43'!
to: aDistanceToStop 
	^(self valueInMeters) to: (aDistanceToStop valueInMeters) by: 1.! !

!Distance methodsFor: 'intervals' stamp: 'fz 5/29/2017 17:32:25'!
to: aDistanceToStop by: aDistanceForStep 
	^(self valueInMeters) to: (aDistanceToStop valueInMeters) by: (aDistanceForStep valueInMeters).! !

!Distance methodsFor: 'intervals' stamp: 'fz 5/29/2017 17:31:48'!
to: aDistanceToStop by: aDistanceForStep do: aTask
	^(self valueInMeters) to: (aDistanceToStop valueInMeters) by: (aDistanceForStep valueInMeters) do: aTask.! !


!Distance methodsFor: 'initialization' stamp: 'fz 5/29/2017 15:02:57'!
initializeWithValue: aValue andMagnitudeInMeters: aProportion
	valor := aValue.
	proporcion := aProportion.! !


!Distance methodsFor: 'associating' stamp: 'fz 5/29/2017 16:37:18'!
> aDistance 
	^(self valor * self proporcion) > (aDistance valor * aDistance proporcion).! !


!Distance methodsFor: 'arithmetic' stamp: 'fz 5/29/2017 16:40:16'!
* aNumber
	^self class withValueInMeters: self valueInMeters * aNumber.! !

!Distance methodsFor: 'arithmetic' stamp: 'fz 5/29/2017 16:40:46'!
+ aDistance 
"algunos parentesis no son necesarios pero lo agregamos para facilitar la lectura (nos queda más cómodo)"
	^ self class withValueInMeters: (self valueInMeters + aDistance valueInMeters).! !

!Distance methodsFor: 'arithmetic' stamp: 'fz 5/29/2017 16:41:05'!
- aDistance 
"algunos parentesis no son necesarios pero lo agregamos para facilitar la lectura (nos queda más cómodo)"
	^ self class withValueInMeters: (self valueInMeters - aDistance valueInMeters).! !

!Distance methodsFor: 'arithmetic' stamp: 'fz 5/29/2017 16:41:18'!
/ aNumber
	^self class withValueInMeters: self valueInMeters / aNumber.! !


!Distance methodsFor: 'comparing' stamp: 'fz 5/29/2017 16:45:22'!
< aDistance 
	^aDistance > self.! !

!Distance methodsFor: 'comparing' stamp: 'fz 5/29/2017 16:50:18'!
<= aDistance 
	^(self < aDistance) or: (self = aDistance).! !

!Distance methodsFor: 'comparing' stamp: 'fz 5/29/2017 16:41:35'!
= aDistance

	^ self valueInMeters = aDistance valueInMeters.! !

!Distance methodsFor: 'comparing' stamp: 'fz 5/29/2017 16:52:25'!
>= aDistance 
	^(self > aDistance) or: (self = aDistance).! !


!Distance methodsFor: 'converting' stamp: 'fz 5/29/2017 15:46:29'!
adaptToNumber: aNumber andSend: selector
	^ self perform: selector with: aNumber.! !


!Distance methodsFor: 'testing' stamp: 'fz 5/29/2017 14:51:00'!
proporcion
	^proporcion.! !

!Distance methodsFor: 'testing' stamp: 'fz 5/29/2017 14:22:50'!
valor
	^valor.! !

!Distance methodsFor: 'testing' stamp: 'fz 5/29/2017 16:39:43'!
valueInMeters
	^valor * proporcion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'initialization' stamp: 'fz 5/29/2017 18:12:17'!
withValue: aValue andMagnitudeInMeters: aProportion

	(aValue<0) ifTrue: [^self error: self negativeDistanceMessage].
	
	^self new initializeWithValue: aValue andMagnitudeInMeters: aProportion.! !

!Distance class methodsFor: 'initialization' stamp: 'fz 5/29/2017 18:12:51'!
withValueInMeters: aValue 

	(aValue<0) ifTrue: [^self error: self negativeDistanceMessage].
	
	^self new initializeWithValue: aValue andMagnitudeInMeters: 1.! !


!Distance class methodsFor: 'messages' stamp: 'fz 5/29/2017 18:09:33'!
negativeDistanceMessage
	^'No pueden crearse distancias negativas'.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 18:14:33'!
minusOneMeter
	^Distance withValueInMeters: -1.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:48:29'!
oneCentimeter
	^Distance withValue: 1 andMagnitudeInMeters: 1/100.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:48:43'!
oneHundredCentimeters
	^Distance withValue: 100 andMagnitudeInMeters: 1/100.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:48:59'!
oneMeter
	^Distance withValueInMeters: 1.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:49:18'!
twoHundredCentimeters
	^Distance withValue: 200 andMagnitudeInMeters: 1/100.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:49:38'!
twoMeters
	^Distance withValueInMeters: 2.! !

!DistanceFactory methodsFor: 'creation' stamp: 'fz 5/29/2017 17:54:50'!
zeroMeters
	^Distance withValueInMeters: 0.! !
