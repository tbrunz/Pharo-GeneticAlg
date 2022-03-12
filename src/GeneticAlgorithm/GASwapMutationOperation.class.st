"
I represent a GA mutation that works by swapping genes within a gene block.
"
Class {
	#name : #GASwapMutationOperation,
	#superclass : #GAAbstractMutationOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #calculating }
GASwapMutationOperation >> doMutate: anIndividual [
	"Mutate genes of the individual by swapping two gene values."
	
	| index2 tmp |
	self checkForRandomGenerator .
	
	1 to: anIndividual genes size do: [ :index1 | 
		self randomNumber <= mutationRate 
			ifTrue: [ 
				index2 := randomGenerator nextInteger: anIndividual genes size.
				tmp := anIndividual genes at: index1.
				anIndividual genes at: index1 put: (anIndividual genes at: index2) .
				anIndividual genes at: index2 put: tmp
				]
		]
]
