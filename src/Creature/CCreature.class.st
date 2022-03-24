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

{ #category : #configuring }
CCreature >> configureBall: numberOfNodes [ 
	"Produce a ball-like creature."
	
	| existingMuscles |
	muscleGenerator := CMuscleGenerator new 
		minStrength: 0.01;
		deltaStrength: 0.5;
		minLength: 10;
		deltaLength: 80;
		minTime: 20;
		deltaTime: 200 .
		
	"Add some nodes."
	self configureNodes: numberOfNodes .
	
	"Connect each node with all the other nodes."
	existingMuscles := OrderedCollection new.
	nodes do: [ :node1 | 
		(nodes copyWithout: node1) do: [ :node2 | 
			(existingMuscles includes: node1 -> node2) 
				ifFalse: [ self addMuscleFrom: node1 to: node2 .
					existingMuscles 
						add: node1 -> node2; 
						add: node2 -> node1
					]
			]
		].
		
	"Create the visual elements."
	self createElements .
	self randomlyLocateNodes.
]

{ #category : #configuring }
CCreature >> configureNodes: numberOfNodes [ 
	"Add a number of nodes to our creature."
	
	numberOfNodes timesRepeat: 
		[ nodes add: CNode new createElement ] .
]

{ #category : #configuring }
CCreature >> createElements [ 
	"Force the creation of all graphical elements for nodes & muscles."
	
	nodes do: #createElement .
	muscles do: [ :muscle | muscle color: color ] .
	muscles do: #createElement .
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

{ #category : #configuring }
CCreature >> materialize: arrayOfValues [
	"Materialize an array of numbers into a creature."
	
	| valuesPerMuscle |
	valuesPerMuscle := arrayOfValues 
		groupsOf: 5 atATimeCollect: [ :v | v ] .
	
	muscles with: valuesPerMuscle do: [ :muscle :values | 
		muscleGenerator materialize: values inMuscle: muscle
		]
]

{ #category : #accessing }
CCreature >> numberOfMuscles [ 
	"Reply with the number of muscles the creature has."
	
	^ muscles size
]

{ #category : #actions }
CCreature >> reachStable [ 
	"Apply the laws of physics to the creature."
	
	| node1 node2 delta actualLength unit force |
	nodes do: #resetForce .
	muscles do: [ :muscle | 
		node1 := muscle node1 .
		node2 := muscle node2 .
		delta := node2 position - node1 position .
		actualLength := delta r max: 1 .
		unit := delta / actualLength .
		force := 0.1 * muscle strength * 
			(actualLength - muscle length) * unit .
		node1 addForce: force .
		node2 addForce: force negated .
		].
]

{ #category : #configuring }
CCreature >> serialize [ 
	"Serialize the creature into an array of numbers."
	
	^ (muscles 
		flatCollect: [ :muscle | 
			muscleGenerator serializeMuscle: muscle ]) asArray 
]

{ #category : #actions }
CCreature >> simulateNoise [ 
	"Produce some noise in our simulation."
	
	| direction |
	direction := ((randomGenerator nextInteger: 3) - 2) @ 
		((randomGenerator nextInteger: 3) - 2) .
		
	(nodes atRandom: randomGenerator) translateBy: direction .
]
