helper
readNext: val
	bufP := bufP + val.
	lastNonWhiteChar := stream position - buf size + bufP.