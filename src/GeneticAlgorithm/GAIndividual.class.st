"
I represent a model for an individual that evolves via a genetic algorithm.
"
Class {
	#name : #GAIndividual,
	#superclass : #GAObject,
	#instVars : [
		'genes',
		'fitness'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #computing }
GAIndividual >> computeFitnessUsing: fitnessBlock [ 
	"Compute the fitness of myself, if not already computed."
	
	self assert: [ genes notNil ] description: 'Need to have some genes first' .
	
	"Just exit if it's already been computed."
	fitness ifNotNil: [ ^ self ] .
	
	"Compute the fitness score."
	fitness := fitnessBlock value: genes
]

{ #category : #accessing }
GAIndividual >> fitness [

	^ fitness
]

{ #category : #accessing }
GAIndividual >> genes [

	^ genes
]

{ #category : #accessing }
GAIndividual >> genes: someGenes [

	genes := someGenes 
]

{ #category : #accessing }
GAIndividual >> numberOfGenes [

	^ genes size
]
