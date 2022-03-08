class_name List

static func take_last(n: int, lst: Array):
	return lst.slice(len(lst) - n, len(lst))
	
static func take_first(n: int, lst: Array):
	return lst.slice(0, n)

static func drop_last(n: int, lst: Array):
	return lst.slice(0, len(lst) - n)
	
static func drop_first(n: int, lst: Array):
	return lst.slice(n, len(lst))
