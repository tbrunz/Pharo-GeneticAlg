"
I represent the set of crossover operations that can be applied to a GA individual.
"
Class {
	#name : #GAAbstractCrossoverOperation,
	#superclass : #GAOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #calculating }
GAAbstractCrossoverOperation >> crossover: partnerA with: partnerB [ 
	"Reply with a new 'child', which is the result of mixing the two partners."
	
	^ self 
		crossover: partnerA 
		with: partnerB 
		midpoint: (self pickCutPointFor: partnerA)
]

{ #category : #calculating }
GAAbstractCrossoverOperation >> crossover: partnerA with: partnerB midpoint: midpoint [
	"Reply with a new 'child', which is the result of mixing the two partners."
	
	| child crossoverGenes |
	child := GAIndividual new.
	child randomGenerator: randomGenerator .
	
	crossoverGenes := (partnerA genes first: midpoint) , 
		(partnerB genes allButFirst: midpoint) .
	
	child genes: crossoverGenes .
	^ child
]

{ #category : #calculating }
GAAbstractCrossoverOperation >> pickCutPointFor: anIndividual [ 
	
	self subclassResponsibility 
]
