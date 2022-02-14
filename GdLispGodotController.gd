extends Node

signal watch_value

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

func watch(node, key):
	emit_signal('watch_value', node, key)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
