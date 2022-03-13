Class {
	#name : #RobotExitTest,
	#superclass : #TestCase,
	#category : #'Robot-tests'
}

{ #category : #tests }
RobotExitTest >> testRobotExit [
	"Build a robot & a map with 80 wall blocks."
	
	| g map robot |
	map := GARobotMap new fillWithWalls: 80.
	robot := GARobot new.
	robot map: map.
	
	g := GAEngine new.
	g endIfNoImprovementFor: 5.
	g numberOfGenes: 100.
	g populationSize: 250.
	
	"A gene is a cardinal direction to move toward."
	g createGeneBlock: [ :randGen :index :ind |
		#($N $S $W $E) atRandom: randGen ] .
	
	"Fitness is minimizing the path distance between robot & exit."
	g minimizeComparator .
	g fitnessBlock: [ :genes |
		robot followOrders: genes.
		robot position distanceTo: map exitPosition 
		].

	g run.
	g visualize open.

	map drawRobotPath: (robot followOrders: g result).
	map open.	
]

{ #category : #tests }
RobotExitTest >> testRobotExitWithPenalty [
	"Extend #testRobotExit to add a penalty to its fitness."
	
	| g map robot |
	map := GARobotMap new fillWithWalls: 80.
	robot := GARobot new.
	robot map: map.
	
	g := GAEngine new.
	g endIfNoImprovementFor: 5.
	g numberOfGenes: 100.
	g populationSize: 250.
	
	"A gene is a cardinal direction to move toward."
	g createGeneBlock: [ :randGen :index :ind |
		#($N $S $W $E) atRandom: randGen ] .
	
	"Fitness is minimizing the path distance between robot & exit."
	g minimizeComparator .
	g fitnessBlock: [ :genes |
		| path penalty |
		path := robot followOrders: genes.
		penalty := path size / 2.
		(robot position distanceTo: map exitPosition) + penalty 
		].

	g run.
	g visualize open.

	map drawRobotPath: (robot followOrders: g result).
	map open.	
]
