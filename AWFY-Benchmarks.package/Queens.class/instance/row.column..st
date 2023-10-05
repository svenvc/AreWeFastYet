as yet unclassified
row: r column: c

    ^ (freeRows at: r) and: [(freeMaxs at: c + r) and: [(freeMins at: c - r + 8)]]
