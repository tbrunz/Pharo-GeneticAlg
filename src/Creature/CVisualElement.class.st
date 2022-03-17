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

{ #category : #'as yet unclassified' }
CVisualElement >> createElement [ 
	"Inialize the #element variable.  Should be overridden in subclasses."
	
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CVisualElement >> element [ 
	
	^ element
]
