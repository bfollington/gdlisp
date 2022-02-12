class_name Procedure

var name: String

func _init(symbol: Symbol):
	name = symbol._val

func apply(args: Array):
	match name:
		'abs':
			return abs(args[0])
			
		'do':
			return args[len(args) - 1]
			
		'add':
			var res = 0
			for arg in args:
				res += arg
			return res
			
		'subtract':
			var res = 0
			for arg in args:
				res -= arg
			return res
			
		'multiply':
			var res = 1
			for arg in args:
				res *= arg
			return res
			
		'divide':
			var res = 1
			for arg in args:
				res /= arg
			return res
			
		'greater_than':
			return args[0] > args[1]
			
		'less_than':
			return args[0] < args[1]
		
		'print':
			print(args)
		_:
			assert(false, "No definition for procedure " + name)
			return null
