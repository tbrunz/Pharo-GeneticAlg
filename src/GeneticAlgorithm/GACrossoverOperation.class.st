"
I represent a concrete crossover operation for GA individuals.
"
Class {
	#name : #GACrossoverOperation,
	#superclass : #GAAbstractCrossoverOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #calculating }
GACrossoverOperation >> pickCutPointFor: anIndividual [

	"Simply replies with a random number between 1 and the number 
	of genes of the individual provided as an argument."

	^ randomGenerator nextInteger: anIndividual numberOfGenes
]
