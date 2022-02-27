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

{ #category : #creating }
GAIndividual class >> create: numIndividuals individualsAndInitialize: numGenes genesWith: geneBlockFactory [
	"Factory method to create a population of individuals, where 
		numIndividuals = number of individuals to create & return, 
		numGenes = number of genes each individual should have, 
		geneBlockFactory = a one-argument block to generate a gene; 
			Takes a random number generator as an argument.
	Defaults the random number generator object.
	"
	
	^  self create: numIndividuals 
		individualsAndInitialize: numGenes 
		genesWith: geneBlockFactory 
		using: (Random new seed: 42)
]

{ #category : #creating }
GAIndividual class >> create: numIndividuals individualsAndInitialize: numGenes genesWith: geneBlockFactory using: aRandomGenerator [ 
	"Factory method to create a population of individuals, where 
		numIndividuals = number of individuals to create & return, 
		numGenes = number of genes each individual should have, 
		geneBlockFactory = a one-argument block to generate a gene; 
			Takes a random number generator as an argument, 
		randomGenerator = a random number generator.
	"
	
	| someIndividuals individual |
	someIndividuals := OrderedCollection new.
	
	numIndividuals timesRepeat: [ 
		individual := self new.
		individual randomGenerator: aRandomGenerator .
		individual set: numGenes genesUsing: geneBlockFactory .
		someIndividuals add: individual 
		].
	^ someIndividuals 
]

{ #category : #computing }
GAIndividual >> computeFitnessUsing: fitnessBlock [ 
	"Compute the fitness of myself, if not already computed."
	
	self assert: [ genes notNil ] description: 'Need to have some genes first' .
	
	"Just exit if it's already been computed."
	fitness ifNotNil: [ ^ self ] .
	
	"Otherwise, compute the fitness score."
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

{ #category : #initialization }
GAIndividual >> set: numGenes genesUsing: geneBlockFactory [ 
	"Generate a set of genes for an individual."
	
	self checkForRandomGenerator .
	genes := (1 to: numGenes) collect: [ :index | 
		geneBlockFactory cull: randomGenerator cull: index cull: self
		].
]
