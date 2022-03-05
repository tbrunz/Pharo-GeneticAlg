Class {
	#name : #GAPrimeFactorsTest,
	#superclass : #TestCase,
	#instVars : [
		'primeNumbers',
		'candidateFactors'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
GAPrimeFactorsTest >> primeFactorizationFor: composite [

	^ self primeFactorizationFor: composite withPopulation: 10000
]

{ #category : #tests }
GAPrimeFactorsTest >> primeFactorizationFor: composite withPopulation: popSize [

	| g |
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: popSize.
	g numberOfGenes: 10.
	g createGeneBlock: 
		[ :rand :index :ind | candidateFactors atRandom: rand ] .
	g minimizeComparator .
	
	"Simple fitness measure: The target minus product of the random factors."
	g fitnessBlock: [ :genes | 
			((genes inject: 1 into: [ :trial :gene | 
				trial * gene ]) - composite) abs ].
	g run.
	
	^ g result copyWithout: 1
]

{ #category : #running }
GAPrimeFactorsTest >> setUp [
	"Create a list of the first N prime numbers."
	
	super setUp.
	
	primeNumbers := #( 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 ).
	
	candidateFactors := #(1) , primeNumbers .
]

{ #category : #tests }
GAPrimeFactorsTest >> testPrimeFactorization1 [ 

	| g |
	g := self primeFactorizationFor: 345 .
	
	self assert: g equals: #(5 3 23).
]

{ #category : #tests }
GAPrimeFactorsTest >> testPrimeFactorization2 [

	| g |
	g := self primeFactorizationFor: 78390 withPopulation: 50000 .
	
	self assert: g equals: #(13 3 67 5 3 2).
]
