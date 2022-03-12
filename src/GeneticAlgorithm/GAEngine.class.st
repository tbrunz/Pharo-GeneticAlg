"
I am the central class that uses the genetic algorithm.
"
Class {
	#name : #GAEngine,
	#superclass : #GAObject,
	#instVars : [
		'fitnessBlock',
		'createGeneBlock',
		'numberOfGenes',
		'populationSize',
		'logs',
		'population',
		'terminationBlock',
		'compareFitness',
		'mutationOperator',
		'crossoverOperator',
		'selection',
		'beforeCreatingInitialIndividual'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GAEngine >> beforeCreatingInitialIndividual: oneArgBlock [
	"Set the behavior to be executed before creating an individual."
	"The block takes a random number generator as an argument."
	
	beforeCreatingInitialIndividual := oneArgBlock
]

{ #category : #configuring }
GAEngine >> beforeRun [ 
	"This method is executed before creating the initial population."
	
	self checkIfReadyToRun .
	selection fitnessBlock: fitnessBlock .
	selection populationSize: populationSize .
]

{ #category : #configuring }
GAEngine >> checkIfReadyToRun [ 
	"Raise an exception if the configuration is not ready to be run."
	
	self assert: [ fitnessBlock notNil ] 
		description: 'Need to set a fitnessBlock' .
		
	self assert: [ createGeneBlock notNil ] 
		description: 'Need to set a createGeneBlock' .
		
	self assert: [ numberOfGenes notNil ]
		description: 'Need to set numberOfGenes' .
		
	self assert: [ logs isEmpty ] 
		description: 'Has already been run' .
]

{ #category : #accessing }
GAEngine >> createGeneBlock: threeArgBlock [
	"Three arguments must be provided for the block argument: 
	randomNumberGen, individualIndex, and the individual."

	createGeneBlock := threeArgBlock .
	mutationOperator geneFactoryBlock: threeArgBlock .
]

{ #category : #calculating }
GAEngine >> crossover: partnerA with: partnerB [ 
	"Delegate a crossover operation between the two arguments."
	
	^ crossoverOperator crossover: partnerA with: partnerB
]

{ #category : #accessing }
GAEngine >> crossoverOperator: aCrossoverOperator [
	"Set the crossover operator used in the algorithm."
	
	crossoverOperator := aCrossoverOperator .
	crossoverOperator randomGenerator: randomGenerator .
]

{ #category : #stopping }
GAEngine >> endForMaxNumberOfGenerations: numOfGenerations [ 
	"Strategy: End the algorithm run after a fixed number of generations."
	
	terminationBlock := 
		[ logs last generationNumber >= numOfGenerations ]
]

{ #category : #stopping }
GAEngine >> endIfFitnessAtOrAbove: aFitnessThreshold [ 
	"Strategy: End the algorithm run if the best fitness value exceeds a threshold."
	
	terminationBlock := 
		[ logs last fittestIndividual fitness >= aFitnessThreshold ]
]

{ #category : #stopping }
GAEngine >> endIfNoImprovementFor: numOfGenerations [ 
	"Strategy: End the algorithm run if no improvement within a number of generations."
	
	^ self endIfNoImprovementFor: numOfGenerations withinRangeOf: 0
]

{ #category : #stopping }
GAEngine >> endIfNoImprovementFor: numOfGenerations withinRangeOf: deltaFitness [
	"End if no improvement within a delta within a number of generations."
	
	terminationBlock := [ 
		(logs last generationNumber >= numOfGenerations) and: [ 
			| allFitness |
			allFitness := (logs last: numOfGenerations) collect: [ :thisLog | 
				thisLog fittestIndividual fitness ] .
			(allFitness max - allFitness min) <= deltaFitness .
			]
		]
]

{ #category : #accessing }
GAEngine >> fitnessBlock [

	^ fitnessBlock
]

{ #category : #accessing }
GAEngine >> fitnessBlock: oneArgBlock [
	"The argument block is evaluated on the genes of each individual."
	"The block has to compute the individual's fitness."

	fitnessBlock := oneArgBlock
]

{ #category : #viewing }
GAEngine >> gtInspectorLogsIn: composite [ 

	<gtInspectorPresentiationOrder: -5>
	composite list 
		title: 'Logs';
		display: [ self logs ]
]

{ #category : #viewing }
GAEngine >> gtInspectorViewIn: composite [ 
	
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self visualize ]
]

{ #category : #initialization }
GAEngine >> initialize [ 

	super initialize .
	logs := OrderedCollection new.
	randomGenerator := Random seed: 42 .
	self endForMaxNumberOfGenerations: 10 . 
	populationSize := 10 .
	self maximizeComparator .
	
	mutationOperator := GAMutationOperation new.
	mutationOperator mutationRate: 0.01 .
	mutationOperator randomGenerator: randomGenerator .
	
	crossoverOperator := GACrossoverOperation new.
	crossoverOperator randomGenerator: randomGenerator .
	
	self selection: GATournamentSelection new.
	
	beforeCreatingInitialIndividual := [ :random | 
		"do nothing per the default"
		].
]

{ #category : #configuring }
GAEngine >> initializePopulation [ 
	"Create a population for the run."
	
	self checkForRandomGenerator .
	population := OrderedCollection new.
	
	populationSize timesRepeat: [ 
		| ind |
		beforeCreatingInitialIndividual value: randomGenerator .
		ind := GAIndividual new.
		population add: (ind 
			randomGenerator: randomGenerator ;
			set: numberOfGenes genesUsing: createGeneBlock)
		]
]

{ #category : #calculating }
GAEngine >> isIndividual: anIndividual betterThan: aFittestIndividual [ 
	"Compare an individual against the population's fittest individual."
	
	^ compareFitness 
		value: anIndividual fitness 
		value: aFittestIndividual fitness .
]

{ #category : #accessing }
GAEngine >> logs [
	"Return the logs of the run."
	
	^ logs
]

{ #category : #comparing }
GAEngine >> maximizeComparator [ 
	"The better individual is the one with the larger fitness value."
	
	compareFitness := [ :f1 :f2 | f1 > f2 ]
]

{ #category : #calculating }
GAEngine >> microPause [ 
	"Cooperative multitasking: Yield the process briefly to other processes."
	"This allows the Transcript, et al, to update themselves."
	
	(Delay forMilliseconds: 1) wait.
	World doOneCycleNow .
]

{ #category : #comparing }
GAEngine >> minimizeComparator [ 
	"The better individual is the one with the lower fitness value."
	
	compareFitness := [ :f1 :f2 | f1 < f2 ]
]

{ #category : #calculating }
GAEngine >> mutate: anIndividual [ 
	"Delegate the job of mutating the child argument."
	
	^ mutationOperator mutate: anIndividual
]

{ #category : #accessing }
GAEngine >> mutationOperator: aMutationOperator [

	mutationOperator := aMutationOperator .
	mutationOperator randomGenerator: randomGenerator .
]

{ #category : #accessing }
GAEngine >> mutationRate: aFloat [
	"Set the mutation rate used by the engine."
	"The default is 0.01 (slow)."
	
	mutationOperator mutationRate: aFloat .
]

{ #category : #accessing }
GAEngine >> numberOfGenes [

	^ numberOfGenes
]

{ #category : #accessing }
GAEngine >> numberOfGenes: anInteger [
	"Set the number of genes each individual will have."

	numberOfGenes := anInteger
]

{ #category : #accessing }
GAEngine >> populationSize: anInteger [

	populationSize := anInteger
]

{ #category : #calculating }
GAEngine >> produceNewPopulation [ 
	"This method does two important things: 
		- Produces a new population & sets it;
		- Selects the fittest individual in it."
		
	selection doSelection .
	population := selection population .
]

{ #category : #calculating }
GAEngine >> randomNumber: maxNumber [
	"Reply with a random number between 1 and maxNumber."

	^ randomGenerator nextInteger: maxNumber
]

{ #category : #calculating }
GAEngine >> result [ 
	"Reply with the genes of the fittest individual found."
	"This method is expected to be called after #run has completed."
	
	^ self logs last fittestIndividual genes
]

{ #category : #calculating }
GAEngine >> run [ 
	"This is the central method of the algorithm -- run it."
	
	| thisTime log |
	self beforeRun .
	self initializePopulation .
	selection initialPopulation: population .
	selection compareFitness: compareFitness .
	
	UIManager default 
		informUserDuring: [ :bar | 
			| gen |
			gen := 0.
			[ self shouldTerminate ] whileFalse: [ 
				gen := gen + 1 .
				bar label: gen asString.
				self microPause.
				thisTime := Time now asSeconds .
				self produceNewPopulation.
				
				log := GALog new.
				log generationNumber: gen.
				log fittestIndividual: selection fittest .
				
				log worstFitness: ( (population collect: #fitness) 
					inject: log bestFitness into: [ :worstFit :thisFitness | 
						(compareFitness value: worstFit value: thisFitness) 
							ifTrue: [ thisFitness ] ifFalse: [ worstFit ]
					] ).
				log averageFitness: (population collect: #fitness)
					average asFloat.
				log timeToProduceGeneration: Time now asSeconds - thisTime .
				logs add: log
				]
			]
]

{ #category : #accessing }
GAEngine >> selection [

	^ selection
]

{ #category : #accessing }
GAEngine >> selection: aSelection [
	"Set the selection method to be used to create a new population."

	selection := aSelection .
	aSelection engine: self .
]

{ #category : #calculating }
GAEngine >> shouldTerminate [ 
	"Reply with a boolean to indicate if the run should conclude."
	
	logs ifEmpty: [ ^ false ] .
	^ terminationBlock value
]

{ #category : #viewing }
GAEngine >> visualize [ 
	"Create a visualization of the population evolution."
	
	| g d |
	g := RTGrapher new.
	d := RTData new.
	d label: 'Best Fitness'.
	d interaction popupText: [ :assoc | assoc value bestFitness ] .
	d connectColor: Color blue.
	d noDot.
	d points: self logs.
	d y: #bestFitness.
	d x: #generationNumber.
	g add: d.
	
	d := RTData new.
	d label: 'Worst Fitness'.
	d interaction popupText: [ :assoc | assoc value worstFitness ] .
	d connectColor: Color red.
	d noDot.
	d points: self logs.
	d y: #worstFitness.
	d x: #generationNumber.
	g add: d.
	
	d := RTData new.
	d label: 'Average Fitness'.
	d interaction popupText: [ :assoc | assoc value averageFitness ] .
	d connectColor: Color green.
	d noDot.
	d points: self logs.
	d y: #averageFitness.
	d x: #generationNumber.
	g add: d.
	
	g legend addText: 'Fitness Evolution'.
	g axisY title: 'Fitness'.
	g axisX noDecimal; title: 'Generation'.
	^ g 
]
