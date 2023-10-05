as yet unclassified
pushDisk: disk onPile: pile

    | top |
    
    top := piles at: pile.
    (top notNil and: [ disk size >= top size ])
      ifTrue: [ self error: 'Cannot put a big disk on a smaller one' ].
    
    disk next: top.
    piles at: pile put: disk.
