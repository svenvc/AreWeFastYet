as yet unclassified
verifyResult: result iterations: innerIterations

    innerIterations = 15000 ifTrue: [ ^ (result at: 1) = 46602 and: [(result at: 2) = 5213] ].
    innerIterations =  1500 ifTrue: [ ^ (result at: 1) =  6102 and: [(result at: 2) = 5213] ].
    innerIterations =   150 ifTrue: [ ^ (result at: 1) =  2052 and: [(result at: 2) = 5213] ].
    innerIterations =    15 ifTrue: [ ^ (result at: 1) =  1647 and: [(result at: 2) = 5213] ].
    innerIterations =     1 ifTrue: [ ^ (result at: 1) =  1605 and: [(result at: 2) = 5213] ].
  
    ScriptConsole println: ('No verification result for', innerIterations asString, ' found').
    ScriptConsole println: ('Result is ', (result at: 1) asString, ', ', (result at: 2) asString).
    ^ false