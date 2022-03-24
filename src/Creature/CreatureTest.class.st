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
