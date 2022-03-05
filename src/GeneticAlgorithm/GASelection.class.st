"
I represent an abstract Genetic Algorithm fitness selection mechanism.
"
Class {
	#name : #GASelection,
	#superclass : #Object,
	#instVars : [
		'population',
		'fittest',
		'initialPopulation',
		'fitnessBlock',
		'populationSize',
		'compareFitness',
		'engine'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GASelection >> checkIfEngineSet [

	^ self assert: [ engine notNil ] description: 'Need to set the GA Engine'
]

{ #category : #accessing }
GASelection >> checkIfInitialPopulationSet [

	self assert: [ initialPopulation notNil ] 
		description: 'Need to set the initial population' .
		
	self assert: [ initialPopulation isCollection ] 
		description: 'Initial population must be a collection' .
		
	self assert: [ initialPopulation notEmpty ] 
		description: 'Initial population cannot be empty' .
]

{ #category : #accessing }
GASelection >> compareFitness: aTwoArgBlock [
	"The argument should be a two-argument block 
	that compares the fitness of two individuals."

	compareFitness := aTwoArgBlock
]

{ #category : #creating }
GASelection >> createNewPopulation [ 
	"Create a new population."
	
	self subclassResponsibility 
]

{ #category : #calculating }
GASelection >> crossover: partnerA with: partnerB [ 
	"Reply with one child, the result of the crossover of the two arguments."
	
	^ engine crossover: partnerA with: partnerB 
]

{ #category : #calculating }
GASelection >> doSelection [ 
	"Produce a new population using the selection algorithm."
	
	self checkIfEngineSet .
	self checkIfInitialPopulationSet .
	
	populationSize := initialPopulation size .
	fittest := initialPopulation first.
	
	initialPopulation do: [ :ind | 
		ind computeFitnessUsing: fitnessBlock .
		(self isIndividual: ind betterThan: fittest)
			ifTrue: [ fittest := ind ]
		].
	
	self createNewPopulation .
	initialPopulation := population .
]

{ #category : #accessing }
GASelection >> engine [

	^ engine
]

{ #category : #accessing }
GASelection >> engine: theEngine [
	"Set the GAEngine to which I am associated."

	engine := theEngine .
	self checkIfEngineSet .
]

{ #category : #accessing }
GASelection >> fitnessBlock [

	^ fitnessBlock
]

{ #category : #accessing }
GASelection >> fitnessBlock: aOneArgBlock [
	"The argument is evaluated on the genes of each individual."
	"The block argument has to compute the fitness."

	fitnessBlock := aOneArgBlock
]

{ #category : #accessing }
GASelection >> fittest [

	^ fittest
]

{ #category : #accessing }
GASelection >> initialPopulation: populationAsIndividuals [

	initialPopulation := populationAsIndividuals .
	self checkIfInitialPopulationSet .
]

{ #category : #initialization }
GASelection >> initialize [ 

	super initialize .
	population := OrderedCollection new.
]

{ #category : #calculating }
GASelection >> isIndividual: thisIndividual betterThan: fittestIndividual [
	"Is the first argument more fit than the second argument?"
	
	^ engine isIndividual: thisIndividual betterThan: fittestIndividual 
]

{ #category : #calculating }
GASelection >> mutate: aChild [ 
	"Perform a mutation on the argument."
	
	^ engine mutate: aChild 
]

{ #category : #accessing }
GASelection >> population [

	^ population
]

{ #category : #accessing }
GASelection >> populationSize [

	^ initialPopulation size
]

{ #category : #accessing }
GASelection >> populationSize: anInteger [

	populationSize := anInteger
]

{ #category : #calculating }
GASelection >> randomNumber: aValue [ 
	"Return a random number between 0 and a value."
	
	^ engine randomNumber: aValue 
]
