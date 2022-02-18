class_name GdLisp
"Heavily based on https://norvig.com/lispy.html"

static func tokenize(chars: String):
	var tokens = chars.replace('\n', ' ').replace('	', ' ').replace(',', '').replace('[', ' [ ').replace('(', ' ( ').replace(']', ' ] ').replace(')', ' ) ').replace('"', ' " ').split(' ')
	var filtered_tokens = []
	for token in tokens:
		if token != '' and token != '	':
			filtered_tokens.append(token.strip_edges(true, true))

	return filtered_tokens

static func parse(program: String):
	return read_from_tokens(tokenize(program))

static func read_from_tokens(tokens: Array):
	assert(len(tokens) > 0, "Syntax Error: unexpected EOF")

	var token = tokens.pop_front()

	assert(token != ')', "Syntax Error: unexpected ')'")

	if token == '"':
		var S = '"'
		var count = 0
		var words = []
		while tokens[0] != '"':
			words.append(tokens.pop_front())
			
		for i in range(0, len(words)):
			var w = words[i]
			S += w
			if i < len(words) - 1:
				S += " "

		tokens.pop_front() # pop off '"'
		S += '"'
		return atom(S)

	if token == '(':
		var L = []
		while tokens[0] != ')':
			L.append(read_from_tokens(tokens))
		tokens.pop_front() # pop off ')'
		return L
		
	if token == '[':
		var L = [atom('list')]
		while tokens[0] != ']':
			L.append(read_from_tokens(tokens))
		tokens.pop_front() # pop off ']'
		return L
	else:
		return atom(token)

static func atom(token: String):

	if token.is_valid_integer():
		return int(token)
	elif token.is_valid_float():
		return float(token)
	elif typeof(token) == TYPE_STRING and token[0] == ':':
		return Keyword.new(token.substr(1))
	elif typeof(token) == TYPE_STRING and token[0] == '"' and token[len(token) - 1] == '"':
		return token.replace('"', '')
	else:
		return Symbol.new(token)

static func eval(expression, env):		
	if expression is Keyword:
		return expression._val
		
	if expression is Symbol:
		return env[expression._val]

		
	elif typeof(expression) == TYPE_INT or typeof(expression) == TYPE_REAL or typeof(expression) == TYPE_BOOL or typeof(expression) == TYPE_STRING or typeof(expression) == TYPE_DICTIONARY:
		return expression
		
	elif expression[0] is Symbol and expression[0]._val == 'fn':
		var args = expression[1]
		
		return Closure.new(expression[2], env, args)
	
	elif expression[0] is Symbol and expression[0]._val == 'defn':
		var args = expression[2].slice(1, len(expression[2]))
		var name = expression[1]._val
		
		var c = Closure.new(expression[3], env, args)
		env[name] = c
		return c
		
	elif expression[0] is Symbol and expression[0]._val == 'for':
		var ret = []
		
		var local_env = env.duplicate()
		for it in eval(expression[2], env):
			local_env[expression[1]._val] = it
			ret.append(eval(expression[3], local_env))
		
		return ret
		
	elif expression[0] is Symbol and expression[0]._val == 'filter':
		var ret = []
		
		var local_env = env.duplicate()
			
		for it in eval(expression[2], env):
			var f = eval(expression[1], local_env)
			var out = f.apply([it])
			if eval(out[0], out[1]):
				ret.append(it)
		
		return ret
		
	elif expression[0] is Symbol and expression[0]._val == 'map':
		var ret = []
		
		var local_env = env.duplicate()
		for it in eval(expression[2], env):
			var f = eval(expression[1], local_env)
			var out = f.apply([it])
			ret.append(eval(out[0], out[1]))
		
		return ret
		
	elif expression[0] is Symbol and expression[0]._val == 'reduce':
		var local_env = env.duplicate()
		var acc = expression[2]
		
		for it in eval(expression[3], env):
			var f = eval(expression[1], local_env)
			var out = f.apply([it, acc])
			acc = eval(out[0], out[1])
		
		return acc
		
	elif expression[0] is Symbol and expression[0]._val == 'if':
		var test = expression[1]
		var conseq = expression[2]
		var alt = expression[3]
		if eval(test, env):
			return eval(conseq, env)
		else: 
			return eval(alt, env) 
		
	elif expression[0] is Symbol and expression[0]._val == 'def':
		var symbol = expression[1]
		var e = expression[2]

		env[symbol._val] = eval(e, env)
		
	elif expression[0] is Symbol and expression[0]._val == 'let':
		var args = expression[1].slice(1, len(expression[1]))
		var body = expression.slice(2, len(expression) - 1)
		assert(len(args) % 2 == 0)
		
		var local_env = env.duplicate()
		
		for i in range(0, len(args), 2):
			local_env[args[i]._val] = eval(args[i + 1], local_env)
		
		var e = [atom('do')]
		for subexp in body:
			e.append(subexp)
		
		return eval(e, local_env)
		
	elif expression[0] is Symbol and expression[0]._val == '->':
		var value = expression[1]
		var steps = expression.slice(2, len(expression))
		
		for s in steps:
			s.append(value)
			value = eval(s, env)

		return value
		
	else:
		var to_check = eval(expression[0], env)
		if to_check is Closure:
			var args = []
			for i in range(1, len(expression)):
				args.append(eval(expression[i], env))
				
			var out = to_check.apply(args)
			
			return eval(out[0], out[1])
			pass
		elif to_check is Procedure:
			var proc: Procedure = to_check
			var args = []
			for i in range(1, len(expression)):
				args.append(eval(expression[i], env))
			return proc.apply(args)
		else:
			return expression
