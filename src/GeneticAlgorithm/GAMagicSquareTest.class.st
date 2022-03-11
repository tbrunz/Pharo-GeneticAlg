Class {
	#name : #GAMagicSquareTest,
	#superclass : #TestCase,
	#instVars : [
		'numList',
		'sumIndices',
		'sumTarget'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
GAMagicSquareTest >> setUp [
	super setUp.
	
	"List of numbers to distribute."
	numList := #(2 4 6 8 10 12 14 16 18).
	
	"Target value for each sum direction."
	sumTarget := 30.
	
	"Indices of the magic square to sum over."
	sumIndices := { 
		"Horizontal sums"
		#(1 2 3).
		#(4 5 6).
		#(7 8 9).
		
		"Diagonal sums"
		#(1 5 9).
		#(7 5 3).
		
		"Vertical sums"
		#(1 4 7).
		#(2 5 8).
		#(3 6 9).
		}.
]

{ #category : #tests }
GAMagicSquareTest >> testMagicSquare [ 

	| g v label elements | 
	g := GAEngine new.
	g populationSize: 400.
	g mutationRate: 0.01.
	g numberOfGenes: numList size.
	g endIfFitnessAtOrAbove: numList size.
	
	g createGeneBlock: [ :randGen :index :ind | 
		numList atRandom: randGen 	
		].
	
	g fitnessBlock: [ :genes | 
		| score penalty |
		"Determine score by adding up each direction (set of indices);
		For each sum in this collection, add their deviation from the target sum."
		score := (sumIndices collect: [ :indSet |
			(indSet collect: [ :index | genes at: index] ) sum ]) 
				inject: 0 into: [ :a :b | a + (b - sumTarget) abs ] .
		"We want every value in the pool to be represented exactly once."
		penalty := (genes size - genes asSet size) * 3.
		"Minimize the score and the penalty."
		9 - (score + penalty)
		].
	
	g run.
	
	self assert: g result asArray equals: #( 12 14 4 2 10 18 16 6 8 ) .
	
	"Visualize the grid."
	v := RTView new.
	label := RTLabel new.
	elements := label elementsOn: g result.
	v addAll: elements.
	RTGridLayout on: elements.
	v open.
	
	"Visualize the fitness evolution."
	g visualize open.
]
