"
I represent a join point of the creature being modeled.
"
Class {
	#name : #CNode,
	#superclass : #CVisualElement,
	#instVars : [
		'speedVector',
		'force',
		'isOnPlatform'
	],
	#category : #'Creature-Core'
}

{ #category : #actions }
CNode >> addForce: aForceAsPoint [ 
	"Make the node the subject of an external force."
	
	force := force + aForceAsPoint .
]

{ #category : #actions }
CNode >> beat [
	"Make the node act according to the force and speed applied."
	
	speedVector := (speedVector + self gravityForce + force) * 0.9 .
	
	isOnPlatform ifTrue: [ speedVector := (speedVector x) * 0.3 @ (speedVector y) ] .
	
	self translateBy: speedVector .
]

{ #category : #actions }
CNode >> checkForCollision: platforms [ 
	"Verify if the node is on a platform.  If so, set the variable true."
	
	isOnPlatform := false.
	platforms do: [ :platform | 
		(platform collide: self)
			ifTrue: [ 
				speedVector := (speedVector x) @ 0 .
				platform adjustNodeIfNecessary: self.
				isOnPlatform := true.
				^ self
				]
		].
]

{ #category : #accessing }
CNode >> createElement [ 
	"Inialize the #element variable."
	
	element := RTEllipse new 
		size: 10;
		color: Color gray trans;
		element .
		
	element @ RTDraggable .
]

{ #category : #actions }
CNode >> gravityForce [
	"This is a fixed force representing gravity."
	
	^ 0 @ 0.3
]

{ #category : #initialization }
CNode >> initialize [ 

	super initialize .
	isOnPlatform := false.
	self resetSpeed.
	self resetForce.
]

{ #category : #accessing }
CNode >> isOnPlatform [ 

	^ isOnPlatform 
]

{ #category : #accessing }
CNode >> position [

	^ element position
]

{ #category : #initialization }
CNode >> resetForce [
	"Reset the force acting on the node."
	
	force := 0 @ 0 .
]

{ #category : #initialization }
CNode >> resetSpeed [
	"Make the node stop by cancelling its speed."
	
	speedVector := 0 @ 0 .
]

{ #category : #actions }
CNode >> translateBy: aPoint [ 
	"Translate the node by an incremental point."
	
	element translateBy: aPoint.
]

{ #category : #actions }
CNode >> translateTo: aPoint [ 
	"Translate the node to a new position."
	
	element translateTo: aPoint.
]
