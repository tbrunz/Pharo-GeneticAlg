"
I represent a muscle that oscillates with an internal clock.
"
Class {
	#name : #CMuscle,
	#superclass : #CConnection,
	#instVars : [
		'time',
		'time1',
		'time2',
		'length1',
		'length2',
		'strength',
		'color'
	],
	#category : #'Creature-Core'
}

{ #category : #actions }
CMuscle >> beat [ 
	"Beating a muscle increases its timer."
	
	time := time + 1 .
	time = self maxTime ifTrue: [ time := 0 ] .
]

{ #category : #accessing }
CMuscle >> color: aColor [ 
	"Set the color of the muscle."
	
	color := aColor
]

{ #category : #accessing }
CMuscle >> createElement [ 
	"A muscle is a transparent line drawn between 2 nodes."
	
	element := RTLine new 
		color: (color alpha: 0.3);
		width: 5;
		edgeFrom: node1 element to: node2 element .
]

{ #category : #initialization }
CMuscle >> initialize [ 

	super initialize .
	time := 0.
	color := Color red.
]

{ #category : #accessing }
CMuscle >> length1 [
	"Length of the muscle at the beginning of the cycle."

	^ length1
]

{ #category : #accessing }
CMuscle >> length1: lengthAsInteger [
	"Set the muscle length at the beginning of a cycle."

	length1 := lengthAsInteger
]

{ #category : #accessing }
CMuscle >> length2 [
	"Length of the muscle at the end of the cycle."

	^ length2
]

{ #category : #accessing }
CMuscle >> length2: lengthAsInteger [
	"Set the muscle length at the end of a cycle."

	length2 := lengthAsInteger
]

{ #category : #accessing }
CMuscle >> maxTime [ 
	"Return the cycle length."
	
	^ time1 max: time2
]

{ #category : #accessing }
CMuscle >> minTime [ 
	"Return the time threshold to switch between #length1 & #length2."
	
	^ time1 min: time2
]

{ #category : #accessing }
CMuscle >> strength [

	^ strength
]

{ #category : #accessing }
CMuscle >> strength: strengthAsFloat [

	strength := strengthAsFloat
]

{ #category : #accessing }
CMuscle >> time1 [

	^ time1
]

{ #category : #accessing }
CMuscle >> time1: timeAsInteger [

	time1 := timeAsInteger
]

{ #category : #accessing }
CMuscle >> time2 [

	^ time2
]

{ #category : #accessing }
CMuscle >> time2: timeAsInteger [

	time2 := timeAsInteger
]

{ #category : #actions }
CMuscle >> usesNodes: twoNodes [ 
	"Accept an array of two nodes and reply true if the muscle connects them."
	
	^ (node1 == twoNodes first 
		and: [ node2 == twoNodes second ]) or: 
			[ node1 == twoNodes second 
				and: [ node2 == twoNodes first ] ]
]
