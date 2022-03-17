"
I represent a platform in the Creature's world.

I am also modeled as a Roassal element.
"
Class {
	#name : #CPlatform,
	#superclass : #CVisualElement,
	#instVars : [
		'width',
		'height'
	],
	#category : #'Creature-Core'
}

{ #category : #actions }
CPlatform >> adjustNodeIfNecessary: node [ 
	"Translate the node above a platform if it ends up inside a platform."
	"Note that the Y-axis increases toward the screen bottom."
	
	| bottomOfNode topOfPlatform |
	bottomOfNode := node element encompassingRectangle bottomCenter y.
	topOfPlatform := self element encompassingRectangle topCenter y.
	
	topOfPlatform < bottomOfNode 
		ifTrue: [ node translateBy: 0 @ (topOfPlatform - bottomOfNode) ] .
]

{ #category : #actions }
CPlatform >> collide: node [ 
	"Reply with true if the platform collides with the node argument."
	
	^ node element encompassingRectangle intersects: self element encompassingRectangle 
]

{ #category : #accessing }
CPlatform >> createElement [ 
	"Create the visual representation of a platform."
	
	element ifNotNil: [ "Already created..." ^ self ] .
	element := RTBox new 
		width: width;
		height: height;
		color: Color gray;
		element .
]

{ #category : #accessing }
CPlatform >> height: aHeightAsNumber [ 

	height := aHeightAsNumber .
]

{ #category : #initialization }
CPlatform >> initialize [

	super initialize .
	self width: 100.
	self height: 10.
]

{ #category : #actions }
CPlatform >> translateTo: aPosition [ 
	"Translate the platform to a particular position."
	
	self createElement .
	element translateTo: aPosition .
]

{ #category : #accessing }
CPlatform >> width: aWidthAsNumber [ 

	width := aWidthAsNumber .
]
