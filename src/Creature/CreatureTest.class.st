Class {
	#name : #CreatureTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'creature'
	],
	#category : #'Creature-Tests'
}

{ #category : #'as yet unclassified' }
CreatureTest >> testColdRun [ 

	creature := CCreature new configureBall: 10 .
	world := CWorld new.
	world addCreature: creature .
	world open
]

{ #category : #tests }
CreatureTest >> testMovingForward [ 
	
	| g numberOfNodes numberOfMuscles muscleGen |
	numberOfNodes := 10.
	numberOfMuscles := (CCreature new configureBall: numberOfNodes) numberOfMuscles .
	
	muscleGen := CMuscleGenerator new 
		minStrength: 0.01;
		deltaStrength: 1;
		minLength: 10;
		deltaLength: 80;
		minTime: 20;
		deltaTime: 200.
		
	g := GAEngine new.
	g crossoverOperator: (GAConstrainedCrossoverOperation new 
		possibleCutPoints: (1 to: numberOfMuscles * 5 by: 5) ) .
	g selection: (GATournamentSelection new) .
	g mutationRate: 0.02 .
	g endForMaxNumberOfGenerations: 128 .
	g populationSize: 100 .
	g numberOfGenes: numberOfMuscles * 5 .
	g createGeneBlock: [ :randGen :index | 
		muscleGen valueForIndex: index
		].
	g fitnessBlock: [ :genes | 
		creature := CCreature new configureBall: numberOfNodes .
		creature materialize: genes .
		world := CWorld new.
		world addCreature: creature .
		3000 timesRepeat: [ world beat ] .
		creature position x
		].
	g run.
	g visualize open.
	
	creature := CCreature new configureBall: 10 .
	creature materialize: g result .
	world := CWorld new.
	world addCreature: creature .
	world open .
	
	world := CWorld new.
	creature := CCreature new color: Color red; configureBall: 10 .
	creature materialize: g logs last fittestIndividual genes .
	world addCreature: creature .
	
	world := CWorld new.
	creature := CCreature new color: Color yellow darker darker; configureBall: 10 .
	creature materialize: (g logs at: 50) fittestIndividual genes .
	world addCreature: creature .
	
	world := CWorld new.
	creature := CCreature new color: Color blue darker darker; configureBall: 10 .
	creature materialize: (g logs at: 100) fittestIndividual genes .
	world addCreature: creature .
	
	world := CWorld new.
	creature := CCreature new color: Color green darker darker; configureBall: 10 .
	creature materialize: (g logs at: 120) fittestIndividual genes .
	world addCreature: creature .
	
	world open .
]

{ #category : #'as yet unclassified' }
CreatureTest >> testMultipleCreatures [

	| redCreature yellowCreature blueCreature |
	redCreature := CCreature new configureBall: 7 .
	yellowCreature := CCreature new color: Color yellow; configureBall: 15 .
	blueCreature := CCreature new color: Color blue; configureBall: 10 .
	
	world := CWorld new.
	world addCreature: redCreature .
	world addCreature: yellowCreature .
	world addCreature: blueCreature .
	world open .
	
	blueCreature translateTo: (100 @ -50) .
	yellowCreature translateTo: (200 @ -50) .
]
