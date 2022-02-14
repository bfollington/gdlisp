class_name Procedure

var name: String

func _init(symbol: Symbol):
	name = symbol._val
	
static func invert_string(s:String) -> String:
	var chars_pool = PoolStringArray()
	var length = s.length()
	chars_pool.resize(length)
	for i in length:
		chars_pool[i] = s[i]
	chars_pool.invert()
	return chars_pool.join("")

func apply(args: Array):
	match name:
		'abs':
			return abs(args[0])
			
		'do':
			return args[len(args) - 1]
			
		'int':
			return int(args[0])
			
		'list':
			return args
			
		'v2':
			return Vector2(args[0], args[1])
			
		'v3':
			return Vector3(args[0], args[1], args[2])
			
		'set-x!':
			var t = typeof(args[1])
			
			match t:
				TYPE_VECTOR2:
					return Vector2(args[0], args[1].y)
				TYPE_VECTOR3:
					return Vector3(args[0], args[1].y, args[1].z)
					
		'set-y!':
			var t = typeof(args[1])
			
			match t:
				TYPE_VECTOR2:
					return Vector2(args[1].x, args[0])
				TYPE_VECTOR3:
					return Vector3(args[1].x, args[0], args[1].z)
					
		'set-z!':
			var t = typeof(args[0])
			
			match t:
				TYPE_VECTOR2:
					return Vector2(args[0], args[1].y)
				TYPE_VECTOR3:
					return Vector3(args[1].x, args[1].y, args[0])
			
		'setp!':
			var o = args[2]
			o.set(args[0], args[1])
			return o
		
		'getp':
			var o = args[1]
			return o.get(args[0])
		
		'get-node':
			var r = GdLispGodotController.get_tree().root
			var n = r.get_node(args[0])
			return n
			
		'find-node':
			var r = GdLispGodotController.get_tree().root
			var n = r.find_node(args[0], true, true)
			return n
			
		'dict':
			var d = {}
			for i in range(0, len(args), 2):
				d[args[i]] = args[i+1]
				
			return d
			
		'add':
			var t = typeof(args[0])
			
			if t == TYPE_INT or t == TYPE_REAL:
				var res = 0
				for arg in args:
					res += arg
				return res
			elif t == TYPE_VECTOR3:
				var res = Vector3.ZERO
				for arg in args:
					res += arg
				return res
			elif t == TYPE_VECTOR2:
				var res = Vector2.ZERO
				for arg in args:
					res += arg
				return res
			
		'subtract':
			var t = typeof(args[0])
			
			if t == TYPE_INT or t == TYPE_REAL:
				var res = 0
				for arg in args:
					res -= arg
				return res
			elif t == TYPE_VECTOR3:
				var res = Vector3.ZERO
				for arg in args:
					res -= arg
				return res
			elif t == TYPE_VECTOR2:
				var res = Vector2.ZERO
				for arg in args:
					res -= arg
				return res
			
		'multiply':
			var t = typeof(args[0])
			
			if t == TYPE_INT or t == TYPE_REAL:
				var res = 1
				for arg in args:
					res *= arg
				return res
			elif t == TYPE_VECTOR3:
				var res = Vector3.ONE
				for arg in args:
					res *= arg
				return res
			elif t == TYPE_VECTOR2:
				var res = Vector2.ONE
				for arg in args:
					res *= arg
				return res
			
		'divide':
			var t = typeof(args[0])
			
			if t == TYPE_INT or t == TYPE_REAL:
				var res = 1
				for arg in args:
					res /= arg
				return res
			elif t == TYPE_VECTOR3:
				var res = Vector3.ONE
				for arg in args:
					res /= arg
				return res
			elif t == TYPE_VECTOR2:
				var res = Vector2.ONE
				for arg in args:
					res /= arg
				return res
			
		'greater_than':
			return args[0] > args[1]
			
		'less_than':
			return args[0] < args[1]
			
		'split':
			return args[0].split(args[1])
			
		'str':
			var s = ''
			for a in args:
				s += a
			return s
			
		'reverse':
			var t = typeof(args[0])
			if t == TYPE_STRING:
				return invert_string(args[0])
			elif t == TYPE_ARRAY or t == TYPE_STRING_ARRAY:
				var S = []
				for s in args[0]:
					S.append(s)

				S.invert()
				return S
				
			return args[0]
		
		'print':
			print(args)
		_:
			assert(false, "No definition for procedure " + name)
			return null
