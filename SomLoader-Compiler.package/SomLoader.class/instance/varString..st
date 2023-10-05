helper methods
varString: collectionOfSymbols 
	^ collectionOfSymbols inject: '' into: [:res :sym | res, ' ', sym asString ]