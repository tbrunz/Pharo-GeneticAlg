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

{ #category : #accessing }
GAObject >> randomGen [

	^ randomGenerator
]

{ #category : #accessing }
GAObject >> randomGen: randomNumberGenerator [

	randomGenerator := randomNumberGenerator
]
