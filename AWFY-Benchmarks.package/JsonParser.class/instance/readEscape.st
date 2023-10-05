as yet unclassified
readEscape

    self read.    
    captureBuffer := captureBuffer concatenate: self readEscapeChar.
    self read
