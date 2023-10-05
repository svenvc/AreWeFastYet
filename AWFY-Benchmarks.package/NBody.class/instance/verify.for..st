as yet unclassified
verify: result for: innerIterations

    innerIterations = 250000 ifTrue: [ ^ result = -0.1690859889909308  ].
    innerIterations =      1 ifTrue: [ ^ result = -0.16907495402506745 ].

    ('No verification result for ', innerIterations asString, ' found') println.
    ('Result is: ', result asString) println.
    ^ false
