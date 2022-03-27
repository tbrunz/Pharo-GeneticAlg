Class {
	#name : #GAConstrainedCrossoverOperation,
	#superclass : #GAAbstractCrossoverOperation,
	#instVars : [
		'possibleCutPoints'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GAConstrainedCrossoverOperation >> pickCutPointFor: partner [ 
	"Reply with a cut point."
	
	self assert: [ 	possibleCutPoints notNil ] 
		description: 'Need to provide the possible cut points, using #possibleCutPoints:' .
		
	^ possibleCutPoints at: (randomGenerator nextInteger: possibleCutPoints size)
]

{ #category : #accessing }
GAConstrainedCrossoverOperation >> possibleCutPoints: indices [ 
	"Set the possible cut points considered by the operator."
	
	possibleCutPoints := indices .
]
