Class {
	#name : #GACrossoverOperationTest,
	#superclass : #TestCase,
	#instVars : [
		'ind1',
		'ind2',
		'oper',
		'ordInd1',
		'ordInd2',
		'ordOper'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #setup }
GACrossoverOperationTest >> setUp [ 

	super setUp.
	ind1 := GAIndividual new genes: 'abcd' .
	ind2 := GAIndividual new genes: 'efgh' .
	oper := GACrossoverOperation new.
	
	ordInd1 := GAIndividual new genes: #(8 4 7 3 6 2 5 1 9 0) .
	ordInd2 := GAIndividual new genes: #(0 1 2 3 4 5 6 7 8 9) .
	ordOper := GAOrderedCrossoverOperation new.
]

{ #category : #tests }
GACrossoverOperationTest >> testCrossover1 [ 
	| ind3 |
	ind3 := oper crossover: ind1 with: ind2 midpoint: 2.
	self assert: ind3 genes equals: 'abgh'
]

{ #category : #tests }
GACrossoverOperationTest >> testCrossover2 [
	| ind3 |
	ind3 := oper crossover: ind1 with: ind2 midpoint: 1.
	self assert: ind3 genes equals: 'afgh'
]

{ #category : #tests }
GACrossoverOperationTest >> testCrossover3 [
	| ind3 |
	ind3 := oper crossover: ind1 with: ind2 midpoint: 0.
	self assert: ind3 genes equals: 'efgh'
]

{ #category : #tests }
GACrossoverOperationTest >> testCrossover4 [
	| ind3 |
	oper randomGenerator: (Random seed: 42) .
	
	ind3 := oper crossover: ind1 with: ind2 .
	self assert: ind3 genes equals: 'afgh'
]

{ #category : #tests }
GACrossoverOperationTest >> testOrderedCrossover1 [ 

	| ordInd3 |
	ordInd3 := ordOper crossover: ordInd1 with: ordInd2 from: 4 to: 8.
	
	self assert: ordInd3 genes equals: #(0 4 7 3 6 2 5 1 8 9)
]

{ #category : #tests }
GACrossoverOperationTest >> testOrderedCrossover2 [ 

	| ordInd3 |
	ordInd3 := ordOper crossover: ordInd1 with: ordInd2 from: 1 to: 4.
	
	self assert: ordInd3 genes equals: #(8 4 7 3 0 1 2 5 6 9)
]

{ #category : #tests }
GACrossoverOperationTest >> testOrderedCrossover3 [ 

	| ordInd3 |
	ordInd3 := ordOper crossover: ordInd1 with: ordInd2 from: 9 to: 10.
	
	self assert: ordInd3 genes equals: #(1 2 3 4 5 6 7 8 9 0)
]
