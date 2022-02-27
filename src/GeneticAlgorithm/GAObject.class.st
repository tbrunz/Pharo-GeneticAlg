"
I am an abstract Genetic Algorithm object, the root of all GA objects.

I contain a Random Number Generator, widely used by my descendants.
"
Class {
	#name : #GAObject,
	#superclass : #Object,
	#instVars : [
		'randomGenerator'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #random }
GAObject >> checkForRandomNumber [
	"Ensure that a random number generator has been set."
	
	self 
		assert: [ randomGenerator notNil ]
		description: 'Need to provide a random number generator'
]

{ #category : #accessing }
GAObject >> randomGen [

	^ randomGenerator
]

{ #category : #accessing }
GAObject >> randomGen: randomNumberGenerator [

	randomGenerator := randomNumberGenerator
]

{ #category : #random }
GAObject >> randomNumber [
	"Return a random number between 0.0 and 1.0."
	
	^ randomGenerator next
]
