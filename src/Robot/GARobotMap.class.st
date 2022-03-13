"
I represent the map of a maze that a GA Robot can navigate.
"
Class {
	#name : #GARobotMap,
	#superclass : #Object,
	#instVars : [
		'size',
		'content',
		'path',
		'randomGen',
		'colors'
	],
	#category : #'Robot-Core'
}

{ #category : #visualization }
GARobotMap >> drawRobotPath: aPath [
	"Plot the path of the robot through the maze."
	
	path := aPath.
	aPath do: [ :robotPosition |
		self gridAt: robotPosition 	put: #robot 
		]
]

{ #category : #creating }
GARobotMap >> exitPosition [
	"Put the exit position at the bottom-right of the map."
	
	^ (size - 1) @ (size - 1)
]

{ #category : #creating }
GARobotMap >> fillEntranceAndExitPoints [

	self gridAt: (self initialPosition) put: #start .
	self gridAt: (self exitPosition) put: #exit .
]

{ #category : #creating }
GARobotMap >> fillWithWalls: numOfWalls [ 
	"Fill the map with a given number of walls."
	
	| offsets |
	numOfWalls timesRepeat: [ 
		| x y |
		x := self randomNumber: size.
		y := self randomNumber: size.
		
		offsets := (self randomNumber: 2) = 1
			ifTrue:  [ { 1 @  0 . -1 @  0 } ]
			ifFalse: [ { 0 @ -1 .  0 @ -1 } ] .
			
		self gridAt: (x @ y) put: #wall.
		self gridAt: (x @ y) + offsets first put: #wall.
		self gridAt: (x @ y) + offsets second put: #wall.
		].
	
	self fillEntranceAndExitPoints .
	
	"Don't forget the fill the map border!"
	1 to: size do: [ :index |
		self gridAt: (index @ 1) put: #wall.
		self gridAt: (1 @ index) put: #wall.
		self gridAt: (index @ size) put: #wall.
		self gridAt: (size @ index) put: #wall.
		]
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint [
	"Reply with the content of a map at a given location."
	"Everything outside the map is empty."
	
	(self includesPoint: aPoint) ifFalse: [ ^ #empty ] .
	
	^ (content at: aPoint y) at: (aPoint x)
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint put: aSymbol [
	"Modify the map by setting a map symbol at a location."
	"#aSymbol may be #empty, #wall, #start, #exit, #robot."
	
	(self includesPoint: aPoint) ifFalse: [ ^ self ] .
	
	^ (content at: aPoint y) at: (aPoint x) put: aSymbol 
]

{ #category : #accessing }
GARobotMap >> includesPoint: aPoint [
	"Reply whether or not a point is within the map."
	
	^ ( (1 @ 1) extent: (size @ size) ) containsPoint: aPoint
]

{ #category : #creating }
GARobotMap >> initialPosition [
	"Put the starting position at the top-left of the map."
	
	^ 2 @ 2
]

{ #category : #initialization }
GARobotMap >> initialize [ 

	super initialize .
	randomGen := Random seed: 42 .
	
	"Set the size via an accessor, and initialize the map."
	self size: 30 .
	
	"Set the color palette for the map."
	colors := { 
		#empty -> Color white .
		#wall  -> Color brown .
		#start -> Color red .
		#exit  -> Color green .
		#robot -> Color blue 
		} asDictionary .
		
]

{ #category : #visualization }
GARobotMap >> open [
	"Build and open the visual representation of the map."
	
	| v shape |
	v := RTView new.
	shape := RTBox new 
		size: 10; 
		color: [ :c | colors at: c ] .
	content do: [ :line | v addAll: (shape elementsOn: line) @ RTPopup ].
	
	RTGridLayout new 
		gapSize: 0;
		lineItemsCount: size;
		on: v elements.
	
	v add: (RTLabel elementOn: path size asString, ' Steps').
	
	TRConstraint 
		move: v elements last 
		below: v elements allButLast .
	
	^ v open
]

{ #category : #accessing }
GARobotMap >> randomNumber: anInteger [
	"Reply with a random integer 1..#anInteger."
	
	^ randomGen nextInteger: anInteger 
]

{ #category : #accessing }
GARobotMap >> size: sideLength [
	"Create a new map of the given size and fill it with #empty."
	
	size := sideLength .
	content := Array new: size .
	
	1 to: size do: [ :index |
		content at: index put: (Array new: size withAll: #empty)
		].
	self fillEntranceAndExitPoints
]
