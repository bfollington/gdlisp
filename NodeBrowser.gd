extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tree = $VBoxContainer/Tree

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = tree.create_item()
	root.set_text(0, "/root")
	tree.set_hide_root(true)

	add_node(root, get_tree().root)

	pass # Replace with function body.

func add_node(parent_tree_item, node):
	var tree_item = tree.create_item(parent_tree_item)
	tree_item.set_text(0, node.name)

	for child in node.get_children():
		add_node(tree_item, child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
