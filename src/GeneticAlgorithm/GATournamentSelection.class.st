"
I represent a method of selecting individuals to be a parent: Hold a tournament!
"
Class {
	#name : #GATournamentSelection,
	#superclass : #GASelection,
	#instVars : [
		'tournamentSize'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #creating }
GATournamentSelection >> createNewPopulation [ 
	"Reply with a new population made of newly-bred individuals."
	
	| partnerA partnerB child |
	population := (1 to: self populationSize) collect: [ :seed | 
		engine randomGenerator: (Random seed: seed).
		partnerA := self getGoodIndividual .
		partnerB := self getGoodIndividual .
		child := self mutate: (self crossover: partnerA with: partnerB) .
		child computeFitnessUsing: engine fitnessBlock .
		child 
		]
]

{ #category : #calculating }
GATournamentSelection >> getGoodIndividual [ 
	"Reply with the best individual from (tournamentSize) individuals, 
	each randomly chosen from the population."
	
	| best ind |
	best := nil .
	tournamentSize timesRepeat: [ 
		ind := initialPopulation at: (self randomNumber: initialPopulation size).
		(best isNil or: [ compareFitness value: ind fitness value: best fitness ]) 
			ifTrue: [ best := ind ]
		].
	^ best
]

{ #category : #initialization }
GATournamentSelection >> initialize [ 

	super initialize .
	tournamentSize := 5 .
]
