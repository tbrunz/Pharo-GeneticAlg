"
I represent a world composed of creatures and platforms.
"
Class {
	#name : #CWorld,
	#superclass : #CVisualElement,
	#instVars : [
		'creatures',
		'time',
		'platforms'
	],
	#category : #'Creature-Core'
}

{ #category : #adding }
CWorld >> addCreature: aCreature [ 
	"Add a new creature to the world."
	
	creatures add: aCreature .
	
	"Add all the creature's graphical elements to the view."
	element addAll: (aCreature nodes collect: #element) .
	element addAll: (aCreature muscles collect: #element) .
	
	"Move the creature to its initial position."
	aCreature resetPosition .
]

{ #category : #configuring }
CWorld >> addGround [
	"Define the ground plane of the creatures' world."
	
	| platform |
	"Give an extra distance to make sure there is no issue with the border."
	platform := CPlatform new
		width: self groundLength + 500 .
	self addPlatform: platform.
	
	"The platform is located below where creatures will be initially located."
	platform translateTo: (self groundLength / 2) @ 100 .
]

{ #category : #adding }
CWorld >> addPlatform: aPlatform [ 
	"Add a new platform the the world."
	
	platforms add: aPlatform .
	aPlatform createElement .
	element add: aPlatform element .
]

{ #category : #adding }
CWorld >> addPylons [ 
	"Add some pylons to the world as visual decoration."
	
	(0 to: self groundLength by: 100) 
		do: [ :flagPosition | 
			| pylon |
			pylon := RTBox new
				color: Color green darker;
				width: 3;
				height: 100;
				elementOn: flagPosition .
			element add: pylon .
			pylon @ RTLabeled .
			pylon translateTo: flagPosition @ 50 .
			pylon pushBack .
			]
]

{ #category : #actions }
CWorld >> beat [ 
	"Trigger a global time beat (e.g., at each window refresh."
	
	time := time + 1 .
	creatures do: [ :creature | 
		creature beat; checkForCollision: platforms .
		]
]

{ #category : #accessing }
CWorld >> createElement [ 
	"Inialize the #element variable, which is a Roassal view."
	
	element := RTView new . 
]

{ #category : #accessing }
CWorld >> groundLength [
	"Reply with the length of the ground platform."
	
	^ 5000
]

{ #category : #initialization }
CWorld >> initialize [ 

	super initialize .
	creatures := OrderedCollection new.
	platforms := OrderedCollection new.
	time := 0.
	
	self createElement .
	self addGround .
]

{ #category : #actions }
CWorld >> open [ 
	"Build the visual representation of the world."
	
	| label animation |
	creatures do: #resetPosition .
	label := (RTLabel new elementOn: time) setAsFixed; yourself .
	element add: label .
	
	label translateBy: (80 @ 30) .
	animation := RTActiveAnimation new 
		intervalInMilliseconds: 10;
		blockToExecute: [ 
			| pos |
			self beat .
			label trachelShape text: time asString .
			pos := creatures first position x @ 0 .
			element canvas camera translateTo: pos .
			pos x > self groundLength 
				ifTrue: [ element removeAnimation: animation ]
			].
		
	element addAnimation: animation .
	self addPylons .
	element canvas camera scale: 2.2 .
	^ element open
]
