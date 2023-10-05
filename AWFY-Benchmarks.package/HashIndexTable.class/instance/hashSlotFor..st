as yet unclassified
hashSlotFor: element

    ^ ((self stringHash: element) & (hashTable size - 1)) + 1
