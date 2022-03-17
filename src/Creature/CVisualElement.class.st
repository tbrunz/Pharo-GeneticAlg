"
I represent the visual elements of a 'Creature' being modeled.

My visual elements are dedicated Roassal elements.
"
Class {
	#name : #CVisualElement,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'Creature-Core'
}

{ #category : #accessing }
CVisualElement >> createElement [ 
	"Inialize the #element variable.  Should be overridden in subclasses."
	
	self subclassResponsibility 
]

{ #category : #accessing }
CVisualElement >> element [ 
	
	^ element
]
