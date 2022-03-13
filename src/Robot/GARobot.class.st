"
I representa simple robot model that follows Genetic Algorithms to exit a maze.
"
Class {
	#name : #GARobot,
	#superclass : #Object,
	#instVars : [
		'position',
		'map'
	],
	#category : #'Robot-Core'
}

{ #category : #operating }
GARobot >> followOrders: orders [ 
	"Make the robot follow the movement orders."
	"Reply with the path taken by the robot."
	"Note: Y coordinates increase toward the screen *bottom*."
	
	| delta path trialPosition |
	delta := { 
		$N -> (0 @ -1) .
		$S -> (0 @ 1) .
		$E -> (1 @ 0) .
		$W -> (-1 @ 0)
		} asDictionary .
		
	path := OrderedCollection new.
	path add: map initialPosition .
	self position: map initialPosition .
	
	orders do: [ :direction | 
		trialPosition := position + (delta at: direction).
		
		"If we've found the exit, return; no further progress."
		trialPosition == map exitPosition ifTrue: [ ^ path ] .
		
		"If there's no wall, then execute the move."
		(map gridAt: trialPosition) ~= #wall ifTrue: [ 
			position := trialPosition .
			path add: position .
			]
		].
	^ path
]

{ #category : #accessing }
GARobot >> map [

	^ map
]

{ #category : #accessing }
GARobot >> map: aMap [

	map := aMap
]

{ #category : #accessing }
GARobot >> position [

	^ position
]

{ #category : #accessing }
GARobot >> position: aPoint [

	position := aPoint
]
