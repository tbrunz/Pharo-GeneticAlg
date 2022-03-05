Class {
	#name : #GAMutationOperationTest,
	#superclass : #TestCase,
	#instVars : [
		'ind1',
		'oper'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
GAMutationOperationTest >> setUp [
	super setUp.
	
	ind1 := GAIndividual new genes: 'abcd' asArray .
	oper := GAMutationOperation new.
]

{ #category : #tests }
GAMutationOperationTest >> testMustBeSetItems [ 

	 self should: [ oper mutate: ind1 ] raise: AssertionFailure .
	
	oper randomGenerator: Random new.
	self should: [ oper mutate: ind1 ] raise: AssertionFailure .
	
	oper geneFactoryBlock: [ :random | 42 ] .
	self shouldnt: [ oper mutate: ind1 ] raise: AssertionFailure .
]

{ #category : #tests }
GAMutationOperationTest >> testMutation [ 
	| ind2 |
	oper randomGenerator: (Random seed: 7).
	oper geneFactoryBlock: [ :random | 
		($a to: $z) atRandom: random
		].
	oper mutationRate: 0.5 .
	
	ind2 := oper mutate: ind1 .
	self assert: ind2 genes equals: 'xfcd' asArray.
	
	ind2 := oper mutate: ind2 .
	self assert: ind2 genes equals: 'tfcd' asArray.
	
	ind2 := oper mutate: ind2 .
	self assert: ind2 genes equals: 'tfjd' asArray.
]
