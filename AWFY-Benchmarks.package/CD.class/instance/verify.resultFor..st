as yet unclassified
verify: actualCollisions resultFor: numAircrafts

    numAircrafts = 1000 ifTrue: [ ^ actualCollisions = 14484 ].
    numAircrafts =  500 ifTrue: [ ^ actualCollisions = 14484 ].
    numAircrafts =  250 ifTrue: [ ^ actualCollisions = 10830 ].
    numAircrafts =  200 ifTrue: [ ^ actualCollisions =  8655 ].
    numAircrafts =  100 ifTrue: [ ^ actualCollisions =  4305 ].
    numAircrafts =   10 ifTrue: [ ^ actualCollisions =   390 ].
    numAircrafts =    2 ifTrue: [ ^ actualCollisions =    42 ].
    
    ScriptConsole println: ('No verification result for ', numAircrafts asString, ' found.').
    ScriptConsole println: ('Result is: ', actualCollisions asString).
    ^ false
