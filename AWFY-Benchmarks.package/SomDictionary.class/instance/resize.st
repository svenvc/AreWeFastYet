as yet unclassified
resize

    | oldStorage |
    oldStorage := buckets.
    buckets := Array new: oldStorage size * 2.
    self transferEntries: oldStorage
