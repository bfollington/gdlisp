extends WindowDialog

var inspect_target: Node = null

onready var label = $VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var ctrl = get_node("/root/GdLispGodotController")
	ctrl.connect("inspect_node", self, "_on_inspect_node")
	pass # Replace with function body.

func _on_inspect_node(node: Node):
	show()
	inspect_target = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if inspect_target == null:
		return

	label.text = inspect_target.name
