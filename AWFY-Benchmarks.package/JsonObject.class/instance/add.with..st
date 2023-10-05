as yet unclassified
add: name with: aJsonValue

    name ifNil: [ self error: 'name is null'  ].
    aJsonValue ifNil: [ self error: 'aJsonValue is null' ].

    table at: name put: names size + 1. "+ 1 for 1-based indexing"
    names  append: name.
    values append: aJsonValue.
