class_name Env

static func default():
	var env = {
		"+": Procedure.new(Symbol.new("add")),
		"-": Procedure.new(Symbol.new("subtract")),
		"*": Procedure.new(Symbol.new("multiply")),
		"/": Procedure.new(Symbol.new("divide")),
		">": Procedure.new(Symbol.new("greater_than")),
		"<": Procedure.new(Symbol.new("less_than")),
		"do": Procedure.new(Symbol.new("do")),
	}
	
	return env
