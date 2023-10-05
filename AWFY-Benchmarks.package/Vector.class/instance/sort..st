as yet unclassified
sort: aBlock

    " Make the argument, aBlock, be the criterion for ordering elements of
       the receiver.
       sortBlocks with side effects may not work right "
    self size > 0 ifTrue: [
      self sort: first
             to: last - 1
           with: aBlock ]
