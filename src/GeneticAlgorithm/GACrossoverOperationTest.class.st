Class {
	#name : #GACrossoverOperationTest,
	#superclass : #TestCase,
	#instVars : [
		'ind1',
		'ind2',
		'oper'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #setup }
GACrossoverOperationTest >> setUp [ 

	super setUp.
	ind1 := GAIndividual new genes: 'abcd' .
	ind2 := GAIndividual new genes: 'efgh' .
	oper := GACrossoverOperation new.
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
