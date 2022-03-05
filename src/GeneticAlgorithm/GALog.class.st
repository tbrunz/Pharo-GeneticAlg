"
I represent the progress of a Genetic Algorithm associated with a generation.
"
Class {
	#name : #GALog,
	#superclass : #Object,
	#instVars : [
		'generationNumber',
		'timeToProduceGeneration',
		'fittestIndividual',
		'worseFitness',
		'averageFitness'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GALog >> averageFitness [

	^ averageFitness
]

{ #category : #accessing }
GALog >> averageFitness: aFitnessValue [

	averageFitness := aFitnessValue
]

{ #category : #accessing }
GALog >> bestFitness [
	"Reply with the best fitness value of the generation I represent."

	^ fittestIndividual fitness
]

{ #category : #accessing }
GALog >> fittestIndividual [

	^ fittestIndividual
]

{ #category : #accessing }
GALog >> fittestIndividual: anIndividual [

	fittestIndividual := anIndividual
]

{ #category : #accessing }
GALog >> generationNumber [

	^ generationNumber
]

{ #category : #accessing }
GALog >> generationNumber: generationNumberAsInteger [

	generationNumber := generationNumberAsInteger
]

{ #category : #printing }
GALog >> printOn: aStream [ 
	"Print the Log object."
	
	super printOn: aStream .
	aStream nextPut: $< .
	aStream nextPutAll: fittestIndividual genes asString .
	aStream nextPut: $> .
]

{ #category : #accessing }
GALog >> timeToProduceGeneration [

	^ timeToProduceGeneration
]

{ #category : #accessing }
GALog >> timeToProduceGeneration: timeAsAnInteger [

	timeToProduceGeneration := timeAsAnInteger
]

{ #category : #accessing }
GALog >> worseFitness [

	^ worseFitness
]

{ #category : #accessing }
GALog >> worseFitness: aFitnessValue [

	worseFitness := aFitnessValue
]
