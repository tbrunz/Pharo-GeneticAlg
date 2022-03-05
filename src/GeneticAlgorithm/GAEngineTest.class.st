Class {
	#name : #GAEngineTest,
	#superclass : #TestCase,
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
GAEngineTest >> testExamples01 [ 

	| g solution |
	solution := 'gato' asArray.
	
	g := GAEngine new.
	g populationSize: 1000.
	g numberOfGenes: 4.
	g createGeneBlock: [ :randGen :index :ind | 
		($a to: $z) atRandom: randGen ] .
	
	"Fitness is how many correct letters in the right places."
	g fitnessBlock: [ :genes | 
		(solution with: genes collect: [ :a :b | 
			a = b ifTrue: [ 1 ] ifFalse: [ 0 ] ] ) sum .
		].
	
	g run.
	self assert: g logs first fittestIndividual fitness equals: 2 .
	self assert: g logs first fittestIndividual genes equals: 'glts' asArray .
	
	self assert: g logs fourth fittestIndividual fitness equals: 4 .
	self assert: g logs fourth fittestIndividual genes equals: 'gato' asArray .
]
