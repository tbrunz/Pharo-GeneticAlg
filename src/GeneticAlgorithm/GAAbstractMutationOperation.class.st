"
I represent the set of mutation operations that can be applied to a GA individual.
"
Class {
	#name : #GAAbstractMutationOperation,
	#superclass : #GAOperation,
	#instVars : [
		'mutationRate'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #calculating }
GAAbstractMutationOperation >> doMutate: anIndividual [
	
	self subclassResponsibility 
]

{ #category : #calculating }
GAAbstractMutationOperation >> geneFactoryBlock: oneArgBlock [ 
	"Do nothing; this may be overridden as necessary."
]

{ #category : #initialization }
GAAbstractMutationOperation >> initialize [ 

	super initialize .
	self mutationRate: 0.01 .
]

{ #category : #calculating }
GAAbstractMutationOperation >> mutate: anIndividual [ 
	"Reply with a new individual, the result of mutating the argument."
	
	| newIndividual |
	newIndividual := GAIndividual new.
	newIndividual randomGenerator: randomGenerator .
	newIndividual genes: anIndividual genes copy.
	
	self doMutate: newIndividual .
	^ newIndividual 
]

{ #category : #accessing }
GAAbstractMutationOperation >> mutationRate [

	^ mutationRate
]

{ #category : #accessing }
GAAbstractMutationOperation >> mutationRate: aFloat [
	"Set the mutation rate, typically a small positive number near zero."
	"Note this should be significantly smaller than one!"

	mutationRate := aFloat
]
