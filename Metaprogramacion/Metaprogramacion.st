!classDefinition: #AddInstanceVariableTest category: #Metaprogramacion!
TestCase subclass: #AddInstanceVariableTest
	instanceVariableNames: 'parentExample sonExample grandsonExample parentVariable sonVariable grandsonVariable'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metaprogramacion'!

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 18:06:14'!
setUp
	parentVariable := 'parentVariable'.
	parentExample := Object subclass: #ParentExample instanceVariableNames: parentVariable classVariableNames: '' poolDictionaries: '' category: 'Metaprogramacion'.
	parentExample compile: 'm1', '|varMethod|'.
	
	sonVariable := 'sonVariable'.
	sonExample := Object subclass: #SonExample instanceVariableNames: sonVariable classVariableNames: '' poolDictionaries: '' category: 'Metaprogramacion'.
	
	grandsonVariable := 'grandsonVariable'.
	grandsonExample := Object subclass: #GrandsonExample instanceVariableNames: grandsonVariable classVariableNames: '' poolDictionaries: '' category: 'Metaprogramacion'.! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:55:26'!
tearDown
	parentExample removeFromSystem.
	sonExample removeFromSystem.
	grandsonExample removeFromSystem.! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:50:48'!
test01CrearUnaVariableConNombreVacioDaError

	self should:[AddInstanceVariable named:'' in: parentExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText  equals: AddInstanceVariable emptyName.
	].! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:51:00'!
test02NombreConSintaxisInvalidaDaError

	self should:[AddInstanceVariable named:'  ' in: parentExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText  equals: AddInstanceVariable invalidName.
	].

	self should:[AddInstanceVariable named:'2+a' in: parentExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText  equals: AddInstanceVariable invalidName.
	].! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 18:08:53'!
test03DefinirUnaVariableExistenteEnLaClaseDaError

	self should:[AddInstanceVariable named:sonVariable in: sonExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText equals: AddInstanceVariable existingName.
	].
! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 18:09:22'!
test03DefinirUnaVariableExistenteEnLaSubclaseDaError

	self should:[AddInstanceVariable named:grandsonVariable in: sonExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText equals: AddInstanceVariable existingName.
	].! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 18:09:31'!
test03DefinirUnaVariableExistenteEnLaSuperclaseDaError

	self should:[AddInstanceVariable named:parentVariable in: sonExample]
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError| 
		self assert: anError  messageText equals: AddInstanceVariable existingName.
	].	
! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:26:56'!
test04DefinirUnaVariableExistenteEnUnMetodoDevuelveUnaAdvertencia

	self should:[AddInstanceVariable named:'varMethod' in: parentExample]
	raise:  Warning 
	withExceptionDo: [:aWarning | 
		self assert: aWarning  messageText  equals: AddInstanceVariable existingLocalName.
	].! !

!AddInstanceVariableTest methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:37:53'!
test05UnaVariableValidaSeCrea

	AddInstanceVariable named:'chau' in: parentExample.
	
	self assert: (parentExample allInstVarNames includes: 'chau').
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddInstanceVariableTest class' category: #Metaprogramacion!
AddInstanceVariableTest class
	instanceVariableNames: 'hola'!


!classDefinition: #AddInstanceVariable category: #Metaprogramacion!
Object subclass: #AddInstanceVariable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Metaprogramacion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AddInstanceVariable class' category: #Metaprogramacion!
AddInstanceVariable class
	instanceVariableNames: ''!

!AddInstanceVariable class methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 16:33:47'!
emptyName
	^'Empty name'.! !

!AddInstanceVariable class methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 17:29:33'!
existingLocalName
	^'existing local name'.! !

!AddInstanceVariable class methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 16:44:54'!
existingName
	^'Existing variable name'.! !

!AddInstanceVariable class methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 16:36:39'!
invalidName
	^'Invalid Name'.! !

!AddInstanceVariable class methodsFor: 'as yet unclassified' stamp: 'fz 7/1/2017 18:04:54'!
named: aName in: aClass

	|parsed refactoring|
"Empty"
	(aName isEmpty) ifTrue:[self error: self emptyName].
	
"Invalid"
	parsed := Scanner new scanFieldNames: aName.
	((parsed size ~= 1) or:[ (parsed at:1) ~= aName]) ifTrue: [self error: self invalidName].
	
"Defined in super/sub/class"
	(aClass allInstVarNamesEverywhere includes: aName) ifTrue: [self error: self existingName].
	
"Defined in method or TODO subclass method"
	aClass methodDictionary do:[:aMethod | 
		(aMethod methodNode tempNames includes: aName) ifTrue:[Warning signal: AddInstanceVariable existingLocalName]
		].
	 
"OK"
	refactoring := [aClass addInstVarName: aName].
	refactoring value.! !
