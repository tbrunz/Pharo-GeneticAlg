"
I represent an ordered GA crossover operation.  I ensure that no genes are duplicated or dropped.
"
Class {
	#name : #GAOrderedCrossoverOperation,
	#superclass : #GAAbstractCrossoverOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #calculating }
GAOrderedCrossoverOperation >> crossover: individualA with: individualB [ 
	"Reply with a new child, the result of mixing two individuals."
	
	| index1 index2 |
	index1 := self pickCutPointFor: individualA .
	index2 := self pickCutPointFor: individualB .
	
	"Make sure 'index1' is smaller than 'index2'."
	(index1 > index2) ifTrue: [ | tmp | 
		tmp := index1. index1 := index2. index2 := tmp ] .
	
	^ self crossover: individualA with: individualB from: index1 to: index2
]

{ #category : #calculating }
GAOrderedCrossoverOperation >> crossover: individualA with: individualB from: index1 to: index2 [
	"Reply with a new child, the result of mixing the two individuals."
	"This method assumes that 'index1' <= 'index2'."
	
	| child crossoverGenes runningIndex swath |
	child := GAIndividual new.
	child randomGenerator: randomGenerator .
	
	swath := individualA genes copyFrom: index1 to: index2 .
	crossoverGenes := Array new: individualA genes size.
	crossoverGenes := crossoverGenes copyReplaceFrom: index1 to: index2 with: swath.
	
	runningIndex := 1.
	(individualB genes copyWithoutAll: swath) do: [ :bGene | 
		(crossoverGenes includes: bGene) ifFalse: [ 
			[ (crossoverGenes at: runningIndex) notNil ] whileTrue: [ 
				runningIndex := runningIndex + 1 ].
			crossoverGenes at: runningIndex put: bGene 	]
		].
	
	child genes: crossoverGenes .
	^ child
]

{ #category : #calculating }
GAOrderedCrossoverOperation >> pickCutPointFor: anIndividual [ 
	"Reply with a random number between 1 and the number of genes of the argument."
	
	^ randomGenerator nextInteger: anIndividual genes size
]
