"
I represent a genetic algorithm Creature, made of modes & muscles.
"
Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'muscles',
		'color',
		'muscleGenerator',
		'randomGenerator'
	],
	#category : #'Creature-Core'
}

{ #category : #adding }
CCreature >> addMuscleFrom: node1 to: node2 [ 
	"Generate and add a muscle between two nodes."
	
	muscles add: (muscleGenerator createMuscleFrom: node1 to: node2) .
]

{ #category : #actions }
CCreature >> beat [ 
	"Execute one unit of behavior."
	
	nodes do: #beat.
	muscles do: #beat.
	self reachStable .
]

{ #category : #actions }
CCreature >> checkForCollision: platforms [ 
	"Check if the creature is on a platform.  If this is the case,
	then the variable #isOnPlatform of each node is net to #true."
	
	nodes do: [ :node | node checkForCollision: platforms ] .
	self simulateNoise .
]

{ #category : #accessing }
CCreature >> color: aColor [ 
	"Override the default color of the creature."
	
	color := aColor 
]

{ #category : #initialization }
CCreature >> initialize [ 

	super initialize .
	nodes := OrderedCollection new.
	muscles := OrderedCollection new.
	randomGenerator := Random seed: 42.
	muscleGenerator := CMuscleGenerator new.
	color := Color red.
]

{ #category : #accessing }
CCreature >> numberOfMuscles [ 
	"Reply with the number of muscles the creature has."
	
	^ muscles size
]

{ #category : #actions }
CCreature >> simulateNoise [ 
	"Produce some noise in our simulation."
	
	| direction |
	direction := ((randomGenerator nextInteger: 3) - 2) @ 
		((randomGenerator nextInteger: 3) - 2) .
		
	(nodes atRandom: randomGenerator) translateBy: direction .
]
