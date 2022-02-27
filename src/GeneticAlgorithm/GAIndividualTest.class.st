Class {
	#name : #GAIndividualTest,
	#superclass : #TestCase,
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
GAIndividualTest >> testCreationWithCharacters [ 

	| r individuals f ind |
	r := Random seed: 42.
	f := [ :rnd | ($a to: $z) atRandom: rnd ] .
	
	individuals := GAIndividual 
		create: 100 
		individualsAndInitialize: 10 
		genesWith: f 
		using: r .
	
	self assert: individuals size equals: 100.
	self assert: (individuals collect: #numberOfGenes) asSet asArray equals: #(10).
	
	ind := individuals anyOne.
	self assert: (ind genes allSatisfy: [ :gene | ($a to: $z) includes: gene ]).
]
