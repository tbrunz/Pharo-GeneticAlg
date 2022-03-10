Class {
	#name : #GAKnapsackProblemTest,
	#superclass : #TestCase,
	#instVars : [
		'knapsackMaxWeight',
		'boxes'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #selecting }
GAKnapsackProblemTest >> selectBoxes: binaryCollection [ 
	"For each 'true' in the provided collection, select the corresponding box."
	
	| boxSet |
	boxSet := OrderedCollection new.
	
	binaryCollection doWithIndex: [ :binary :index | 
		binary = 1
			ifTrue: [ boxSet add: (boxes at: index) ]  
		].
	
	^ boxSet 
]

{ #category : #running }
GAKnapsackProblemTest >> setUp [
	super setUp.
	
	knapsackMaxWeight := 15 .
	
	"A box is { value, weight }"
	boxes := #( #(4 12) #(2 1) #(2 2) #(1 1) #(10 4) #(0 0) ) .
]

{ #category : #tests }
GAKnapsackProblemTest >> test0to1Knapsack [ 

	| g boxSet solution |
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: boxes size.
	
	"Genes are each 'yes/no' values."
	g createGeneBlock: [ :randGen :index :ind | 
		#(0 1) atRandom: randGen ] .
	g maximizeComparator .
	
	g fitnessBlock: [ :genes | 
		| totalWeight totalValue penalty |
		(boxSet := self selectBoxes: genes)
			ifEmpty: [ totalValue := 0. totalWeight := 0 ]
			ifNotEmpty: [ 
				totalValue := (boxSet collect: #first) sum.
				totalWeight := (boxSet collect: #second) sum.
				] .
		penalty := 0.
		knapsackMaxWeight < totalWeight 
			ifTrue: [ penalty := (knapsackMaxWeight - totalWeight) abs * 50 ] .
		totalValue - penalty 
		].
	
	g run.
	solution := self selectBoxes: g result .
	self assert: solution asArray equals: #( #(2 1) #(2 2) #(1 1) #(10 4) ).
]

{ #category : #tests }
GAKnapsackProblemTest >> testUnboundedKnapsack [ 

	| g solution |
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: 15.
	
	g createGeneBlock: [ :randGen :index :ind | 
		boxes atRandom: randGen ] .
	g maximizeComparator .
	
	g fitnessBlock: [ :genes | 
		| totalWeight totalValue penalty |
		totalValue := (genes collect: #first) sum.
		totalWeight := (genes collect: #second) sum.
		penalty := 0.
		knapsackMaxWeight < totalWeight 
			ifTrue: [ penalty := (knapsackMaxWeight - totalWeight) abs * 50 ] .
		totalValue - penalty 
		].
	
	g run.
	solution := g result copyWithout: #(0 0).
	self assert: solution equals: #( #(10 4) #(2 1) #(10 4) #(10 4) #(2 1) #(2 1) ).
]
