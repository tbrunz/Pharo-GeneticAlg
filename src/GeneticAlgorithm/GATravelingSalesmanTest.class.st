"
Genetic Algorithm classes from Alexandre Bergel's 'Agile AI in Pharo' book.
"
Class {
	#name : #GATravelingSalesmanTest,
	#superclass : #TestCase,
	#instVars : [
		'distances',
		'points'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
GATravelingSalesmanTest >> setUp [
	super setUp.
	
	"Create a dictionary of associations."
	distances := { 
		($A -> $B) -> 10 .
		($A -> $C) -> 20 .
		($A -> $D) -> 10 .
		($B -> $C) -> 10 .
		($B -> $D) ->  8 .
		($C -> $D) -> 10 
		} asDictionary .
		
	points := { 
		(100 @ 160) . (20  @  40) . (60  @  20) .
		(180 @ 100) . (200 @  40) . (60  @ 200) .
		(80  @ 180) . (40  @ 120) . (140 @ 180) .
		(140 @ 140) . (20  @ 160) . (200 @ 160) .
		(180 @  60) . (100 @ 120) . (120 @  80) .
		(100 @  40) . (20  @  20) . (60  @  80) . 
		(180 @ 200) . (160 @  20) 
		}
]

{ #category : #tests }
GATravelingSalesmanTest >> testImprovedNaiveApproach [

	| g result v elements |
	g := GAEngine new.
	g endIfNoImprovementFor: 60.
	g populationSize: 5000.
	g numberOfGenes: points size.
	g minimizeComparator.
	g createGeneBlock: [ :randGen :index :ind | 
		points atRandom: randGen ].

	g fitnessBlock: [ :genes | 
		| distance dist |
		distance := 0.
		2 to: genes size do: [ :pointIndex | 
			dist := (genes at: pointIndex) distanceTo:
				(genes at: pointIndex - 1).
			distance := distance + dist ] .
		distance + ((points size - genes asSet size) * 1000) 
		].

	g run.
	g visualize open.
	
	result := g result.
	v := RTView new.
	elements := RTEllipse new 
		size: 10;
		color: Color red trans;
		elementsOn: result .
	elements @ RTPopup.
	v addAll: elements.
	
	elements do: [ :each | each translateTo: each model ].
	2 to: result size do: [ :index | 
		| arrow | 
		arrow := RTArrowedLine new 
			color: Color blue;
			headOffset: 0.8 .
		v add: (arrow 
			edgeFrom: (v elementFromModel: (result at: index - 1)) 
			to: (v elementFromModel: (result at: index)) )
		].
	v open.
]

{ #category : #tests }
GATravelingSalesmanTest >> testNaiveApproach [ 

	| g |
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	"g populationSize: 100."
	g populationSize: 1000.
	g numberOfGenes: 4.
	g minimizeComparator .
	g createGeneBlock: [ :randGen :index :ind | 
		'ABCD' atRandom: randGen ].
	
	g fitnessBlock: [ :genes | 
		| currentCity length |
		currentCity := genes first.
		length := 0.
		
		genes allButFirstDo: [ :nextCity | 
			length := length + (distances at: (currentCity -> nextCity) 
				ifAbsent: [ distances at: (nextCity -> currentCity) 
					ifAbsent: [ 0 ] ] ).
			currentCity := nextCity 
			].
		"length"
		length + ((4 - genes asSet size) * 100)
		].
	
	g run.
	g visualize open.
]

{ #category : #tests }
GATravelingSalesmanTest >> testSophisticatedApproach [

	| g result v elements |
	g := GAEngine new.
	g endIfNoImprovementFor: 5.
	g populationSize: 1000.
	g numberOfGenes: points size.
	g minimizeComparator.
	
	g crossoverOperator: GAOrderedCrossoverOperation new.
	g mutationOperator: GASwapMutationOperation new.
	
	g beforeCreatingInitialIndividual: 
		[ :randGen | points copy shuffleBy: randGen ].	
	g createGeneBlock: [ :randGen :index :ind | points at: index ].

	g fitnessBlock: [ :genes | 
		| distance dist |
		distance := 0.
		2 to: genes size do: [ :pointIndex | 
			dist := (genes at: pointIndex) distanceTo:
				(genes at: pointIndex - 1).
			distance := distance + dist ] .
		distance
		].

	g run.
	g visualize open.
	
	result := g result.
	v := RTView new.
	elements := RTEllipse new 
		size: 10;
		color: Color red trans;
		elementsOn: result .
	elements @ RTPopup.
	v addAll: elements.
	
	elements do: [ :each | each translateTo: each model ].
	2 to: result size do: [ :index | 
		| arrow city1 city2 | 
		arrow := RTArrowedLine new 
			color: Color blue;
			headOffset: 0.8 .
		city1 := v elementFromModel: (result at: index - 1).
		city2 := v elementFromModel: (result at: index).
		v add: (arrow 
			edgeFrom: city1 to: city2)
		].
	v open.
]
