initialize-release
initialize
	lineNumber := 0.
	peekDone := false.
	text := ReadWriteStream on: String new.
	buf := ''.
	bufP := 1.