as yet unclassified
collect: block
 | coll |
    coll := Vector new.
    self forEach: [ :e | coll append: (block value: e) ].
    ^ coll
