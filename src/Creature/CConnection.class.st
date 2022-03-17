"
I represent a connection between a pair of nodes.  I am an oscillating edge with a strength.
"
Class {
	#name : #CConnection,
	#superclass : #CVisualElement,
	#instVars : [
		'node1',
		'node2'
	],
	#category : #'Creature-Core'
}

{ #category : #accessing }
CConnection >> node1 [

	^ node1
]

{ #category : #accessing }
CConnection >> node1: aNode [

	node1 := aNode
]

{ #category : #accessing }
CConnection >> node2 [

	^ node2
]

{ #category : #accessing }
CConnection >> node2: aNode [

	node2 := aNode
]
