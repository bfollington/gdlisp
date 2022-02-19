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
			
		'children':
			return args[0].get_children()
		
		'count':
			return len(args[0])
			
		'watch':
			return GdLispGodotController.watch(args[1], args[0])
			
		'list-properties':
			var node = args[0]
			return node.get_property_list()

		'selected-node':
			var eds = GdLispGodotController.get_tree().root.get_editor_interface().get_selection()
			var selected = eds.get_selected_nodes()
			if len(selected) > 0:
				return selected[0]
			else:
				return null

		'selected-nodes':
			var eds = GdLispGodotController.get_tree().root.get_editor_interface().get_selection()
			return eds.get_selected_nodes()
		
		'get-node':
			if (len(args) == 1):
				var r = GdLispGodotController.get_tree().root
				var n = r.get_node(args[0])
				return n
			else:
				return args[1].get_node(args[0])
			
		'find-node':
			var r = GdLispGodotController.get_tree().root
			if len(args) > 1:
				r = args[1]

			var n = r.find_node(args[0], true, false)
			return n
		
		'find-nodes':
			var r = GdLispGodotController.get_tree().root
			var query = args[0]
			var queue = [r]
			var results = []
			while len(queue) > 0:
				var n = queue.pop_front()
				if query in n.name:
					results.append(n)
				
				for child in n.get_children():
					queue.append(child)
			
			return results
			
		'all-nodes':
			var r = GdLispGodotController.get_tree().root
			var queue = [r]
			var results = []
			while len(queue) > 0:
				var n = queue.pop_front()
				results.append(n)
				
				for child in n.get_children():
					queue.append(child)
			
			return results

		'parent':
			return args[0].get_parent()

		'find-parent':
			var n = args[1].find_parent(args[0])
			return n
			
		'connect':
			var node = args[2]
			var signal_name = args[0]
			var f = args[1]
			
			GdLispGodotController.receive_signal(node, signal_name, f)
			return node
			
		'dict':
			var d = {}
			for i in range(0, len(args[0]), 2):
				d[args[0][i]] = args[0][i+1]
				
			return d
			
		'get':
			if args[1] is Array:
				if len(args[1]) - 1 < args[0]:
					return null
				return args[1][args[0]]
			else:
				return args[1].get(args[0])
			
		'merge':
			var d = {}
			for m in args:
				for k in m.keys():
					d[k] = m[k]
			
			return d
			
		'assoc!':
			args[2][args[0]] = args[1]
			return args[2]
			
		'dissoc!':
			args[1].erase(args[0])
			return args[1]
			
		'eq':
			var res = true
			var last = args[0]
			for a in args:
				res = res and (last == a)
				last = a
			
			return res
			
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
			
		'log':
			var stream = args[0]
			var capture = List.drop_first(1, args)
			
			GdLispGodotController.capture_log(stream, capture)
	
		_:
			assert(false, "No definition for procedure " + name)
			return null
