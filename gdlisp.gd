class_name GdLisp
"Heavily based on https://norvig.com/lispy.html"

static func tokenize(chars: String):
	var tokens = chars.replace('\n', ' ').replace('	', ' ').replace('(', ' ( ').replace(')', ' ) ').split(' ')
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

	if token == '(':
		var L = []
		while tokens[0] != ')':
			L.append(read_from_tokens(tokens))
		tokens.pop_front() # pop off ')'
		return L
	else:
		return atom(token)

static func atom(token: String):

	if token.is_valid_integer():
		return int(token)
	elif token.is_valid_float():
		return float(token)
	elif typeof(token) == TYPE_STRING and token[0] == '"' and token[len(token) - 1] == '"':
		return token.replace('"', '')
	else:
		return Symbol.new(token)

static func eval(expression, env):	
	if expression is Symbol:
		return env[expression._val]
		
	elif typeof(expression) == TYPE_INT or typeof(expression) == TYPE_REAL or typeof(expression) == TYPE_BOOL or typeof(expression) == TYPE_STRING:
		return expression
		
	elif expression[0] is Symbol and expression[0]._val == 'if':
		var test = expression[1]
		var conseq = expression[2]
		var alt = expression[3]
		if eval(test, env):
			return eval(conseq, env)
		else: 
			return eval(alt, env) 
		
	elif expression[0] is Symbol and expression[0]._val == 'define':
		var symbol = expression[1]
		var e = expression[2]

		env[symbol._val] = eval(e, env)
	else:
		var proc: Procedure = eval(expression[0], env)
		var args = []
		for i in range(1, len(expression)):
			args.append(eval(expression[i], env))
		return proc.apply(args)
