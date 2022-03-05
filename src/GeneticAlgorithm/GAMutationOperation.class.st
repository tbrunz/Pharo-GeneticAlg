"
I represent a concrete mutation operation for GA individuals.
"
Class {
	#name : #GAMutationOperation,
	#superclass : #GAAbstractMutationOperation,
	#instVars : [
		'geneFactoryBlock'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GAMutationOperation >> checkForGeneFactory [
	"Ensure that a gene factory has been set."

	self 
		assert: [ geneFactoryBlock notNil ] 
		description: 'Need to provide a block to create genes'
]

{ #category : #calculating }
GAMutationOperation >> doMutate: anIndividual [
	"Mutate the genes of the argument individual."

	self checkForRandomGenerator .
	self checkForGeneFactory .
	
	1 to: anIndividual genes size do: [ :index | 
		self randomNumber <= mutationRate 
			ifTrue: [ anIndividual genes 
				at: index 
				put: (geneFactoryBlock 
					cull: randomGenerator 
					cull: index 
					cull: anIndividual) 
				].
		].
]

{ #category : #accessing }
GAMutationOperation >> geneFactoryBlock [
	"Return a 3-argument block used ot create a gene."
	"It follows this pattern: [ :random :geneIndex :individual | ... ]"

	^ geneFactoryBlock
]

{ #category : #accessing }
GAMutationOperation >> geneFactoryBlock: oneArgBlock [
	"The block should receive a random number as an argument."

	geneFactoryBlock := oneArgBlock
]
