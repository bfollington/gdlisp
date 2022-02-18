class_name Closure

var expression
var environment
var arg_list

func _init(body, env, arg_symbols):
	expression = body
	environment = env
	arg_list = []
	for s in arg_symbols.slice(1, len(arg_symbols) - 1):
		arg_list.append(s._val)
	
func apply(args: Array):
	var local = environment.duplicate()
	for i in range(0, len(arg_list)):
		var local_arg = arg_list[i]
		local[local_arg] = args[i]
	
	return [expression, local]
	
