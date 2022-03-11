Class {
	#name : #GAMeetingRoomTest,
	#superclass : #TestCase,
	#instVars : [
		'meetings',
		'numberOfMeetings',
		'maxMeetingLength'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
GAMeetingRoomTest >> setUp [
	super setUp.
	
	"A meeting is represented by a tuple, (start time, end time)."
	meetings := #( #(1 3) #(2 3) #(5 6) #(7 9) #(4 7) ) .
	
	numberOfMeetings := meetings size.
	maxMeetingLength := 24.
]

{ #category : #tests }
GAMeetingRoomTest >> testMeetingRoomAssignments [

	| g hoursOfOverlap schedule |
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: numberOfMeetings.
	
	"Each gene represents a distinct meeting; its value is the room number."
	"Potentially, each meeting would need its own room, hence #rooms = #meetings."
	g createGeneBlock: [ :randGen :index :ind | 
		(1 to: numberOfMeetings) atRandom: randGen
		].
	g minimizeComparator .
	
	g fitnessBlock: [ :genes | 
		| distribution |
		"Distribution is a set of rooms, each a collection of meetings held there."
		distribution := OrderedCollection new.
		"Potentially, each meeting would need its own room."
		numberOfMeetings timesRepeat: [ distribution add: OrderedCollection new ].
		
		"The gene index is the meeting number; the value is a room number."
		"Distribute the meetings into the rooms as indicated by the genes."
		genes doWithIndex: [ :roomNumber :index | 
			(distribution at: roomNumber) add: (meetings at: index)
			].
		"Now check to see how many rooms have overlapping meetings assigned."
		hoursOfOverlap := 0.
		distribution do: [ :setOfMeetings |
			schedule := OrderedCollection new: maxMeetingLength withAll: 0.
			setOfMeetings do: [ :mtg | 
				"Check each hour in each meeting for conflicts."
				mtg first to: mtg second do: [ :hour | 
					schedule at: hour put: (schedule at: hour) + 1.
					].
				].
			"Accumulate the hours of overlap for all meetings in all rooms."
			hoursOfOverlap := hoursOfOverlap + (schedule select: [ :hour | hour > 1 ]) size .
			].
		"Penalize for using too many rooms and too many overlap hours."
		(distribution select: #notEmpty) size + hoursOfOverlap .
		].
	g run.
	self assert: g result asSet size equals: 2.
]
