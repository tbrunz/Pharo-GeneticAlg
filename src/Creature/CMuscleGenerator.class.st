"
I am responsible for randomly generating a creature muscle.

The attributes of each muscle must themselves be randomly generated.
"
Class {
	#name : #CMuscleGenerator,
	#superclass : #Object,
	#instVars : [
		'randomGenerator',
		'minStrength',
		'deltaStrength',
		'minLength',
		'deltaLength',
		'minTime',
		'deltaTime'
	],
	#category : #'Creature-Core'
}

{ #category : #creating }
CMuscleGenerator >> createMuscleFrom: nodeA to: nodeB [ 
	"Reply with a new muscle connecting two nodes."
	
	| muscle |
	muscle := CMuscle new.
	
	muscle node1: nodeA.
	muscle node2: nodeB.
	
	muscle length1: self generateLength .
	muscle length2: self generateLength .
	
	muscle time1: self generateTime .
	muscle time2: self generateTime .
	
	muscle strength: self generateStrength .
	^ muscle 
]

{ #category : #accessing }
CMuscleGenerator >> deltaLength: lengthAsInteger [

	deltaLength := lengthAsInteger
]

{ #category : #accessing }
CMuscleGenerator >> deltaStrength: strengthAsInteger [

	deltaStrength := strengthAsInteger
]

{ #category : #accessing }
CMuscleGenerator >> deltaTime: timeAsInteger [

	deltaTime := timeAsInteger
]

{ #category : #creating }
CMuscleGenerator >> generateLength [ 
	"Reply with a length within the valid range."
	
	^ minLength + (randomGenerator nextInteger: deltaLength)
]

{ #category : #creating }
CMuscleGenerator >> generateStrength [
	"Reply with a strength within the valid range."
	
	^ randomGenerator next * deltaStrength + minStrength
]

{ #category : #creating }
CMuscleGenerator >> generateTime [
	"Reply with a time within the valid range."
	
	^ (randomGenerator nextInteger: deltaTime) + minTime
]

{ #category : #initialization }
CMuscleGenerator >> initialize [ 

	super initialize .
	self resetSeed.
	
	minLength := 10.
	deltaLength := 30.
	
	minTime := 4.
	deltaTime := 200.
	
	minStrength := 1.
	deltaStrength := 3.
]

{ #category : #creating }
CMuscleGenerator >> materialize: values inMuscle: aMuscle [ 
	"Configure a muscle with a set of values."
	
	aMuscle length1: values first.
	aMuscle length2: values second.
	aMuscle strength: values third.
	aMuscle time1: values fourth.
	aMuscle time2: values fifth.
]

{ #category : #accessing }
CMuscleGenerator >> minLength: lengthAsInteger [

	minLength := lengthAsInteger
]

{ #category : #accessing }
CMuscleGenerator >> minStrength: strengthAsInteger [

	minStrength := strengthAsInteger
]

{ #category : #accessing }
CMuscleGenerator >> minTime: timeAsInteger [

	minTime := timeAsInteger
]

{ #category : #initialization }
CMuscleGenerator >> resetSeed [ 
	
	randomGenerator := Random seed: 42 .
]

{ #category : #creating }
CMuscleGenerator >> serializeMuscle: aMuscle [ 
	"Reply with an array describing the muscle argument."
	
	^ Array 
		with: aMuscle length1 
		with: aMuscle length2 
		with: aMuscle strength 
		with: aMuscle time1 
		with: aMuscle time2 
]

{ #category : #creating }
CMuscleGenerator >> valueForIndex: anIndex [ 
	"Produce a value for a given index of an individual chromosome."
	"This method is used to generate a gene in the genetic algorithm."
	
	| i |
	"Restrict #anIndex from 'Z' to 1..5.  Note that % is the modulo operator."
	i := (anIndex - 1) % 5 .
	
	i = 0 ifTrue: [ ^ self generateLength ] .
	i = 1 ifTrue: [ ^ self generateLength ] .
	i = 2 ifTrue: [ ^ self generateStrength ] .
	i = 3 ifTrue: [ ^ self generateTime ] .
	i = 4 ifTrue: [ ^ self generateTime ] .
	
	self error: 'Should not be here'
]
