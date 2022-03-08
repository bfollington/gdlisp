extends Node

signal emit_log
signal watch_value
signal inspect_node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var signal_id = 0


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

func watch(node, key):
	emit_signal('watch_value', node, key)

func receive_signal(node, signal_name, action):
	node.connect(signal_name, self, "_on_signal_intercept", [node, signal_name, action])
	
func capture_log(stream, values):
	print("LOG ", stream, values)
	emit_signal('emit_log', stream, values)

func inspect(node: Node):
	emit_signal('inspect_node', node)
	
func _on_signal_intercept(node, signal_name, action):
	var out = action.apply([node, signal_name])
	return GdLisp.eval(out[0], out[1])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
