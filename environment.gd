class_name Env

static func default():
	var env = {
		"true": true,
		"false": false,
		"v2": Procedure.new(Symbol.new("v2")),
		"v3": Procedure.new(Symbol.new("v3")),
		"set-x!": Procedure.new(Symbol.new("set-x!")),
		"set-y!": Procedure.new(Symbol.new("set-y!")),
		"set-z!": Procedure.new(Symbol.new("set-z!")),
		"+": Procedure.new(Symbol.new("add")),
		"-": Procedure.new(Symbol.new("subtract")),
		"*": Procedure.new(Symbol.new("multiply")),
		"/": Procedure.new(Symbol.new("divide")),
		">": Procedure.new(Symbol.new("greater_than")),
		"<": Procedure.new(Symbol.new("less_than")),
		"setp!": Procedure.new(Symbol.new("setp!")),
		"getp": Procedure.new(Symbol.new("getp")),
		"children": Procedure.new(Symbol.new("children")),
		"count": Procedure.new(Symbol.new("count")),
		"get-node": Procedure.new(Symbol.new("get-node")),
		"find-node": Procedure.new(Symbol.new("find-node")),
		"list": Procedure.new(Symbol.new("list")),
		"dict": Procedure.new(Symbol.new("dict")),
		"get": Procedure.new(Symbol.new("get")),
		"assoc!": Procedure.new(Symbol.new("assoc!")),
		"dissoc!": Procedure.new(Symbol.new("dissoc!")),
		"merge": Procedure.new(Symbol.new("merge")),
		"int": Procedure.new(Symbol.new("int")),
		"split": Procedure.new(Symbol.new("split")),
		"reverse": Procedure.new(Symbol.new("reverse")),
		"str": Procedure.new(Symbol.new("str")),
		"print": Procedure.new(Symbol.new("print")),
		"do": Procedure.new(Symbol.new("do")),
	}
	
	return env
