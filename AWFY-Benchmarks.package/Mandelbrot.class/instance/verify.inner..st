as yet unclassified
verify: result inner: innerIterations

    innerIterations = 500 ifTrue: [ ^ result = 191 ].
    innerIterations = 750 ifTrue: [ ^ result = 50  ].
    innerIterations = 1   ifTrue: [ ^ result = 128 ].

    ScriptConsole println: ('No verification result for ', innerIterations asString, ' found').
    ScriptConsole println: ('Result is: ', result asString).
    ^ false
