as yet unclassified
add: value

    value ifNil: [ self error: 'value is null' ].
    values append: value
