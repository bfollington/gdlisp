extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var watching = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var ctrl = get_node("/root/GdLispGodotController")
	ctrl.connect("watch_value", self, "_on_value_watched")
	pass # Replace with function body.

func _on_value_watched(node, key):
	watching.append([node, key])
	$Label.text = key
	$Value.text = str(node.get(key))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sets = [[$Label, $Value], [$Label2, $Value2]]
	for i in range(0, len(watching)):
		var label = sets[i][0]
		var value = sets[i][1]
		var watch = watching[i]

		label.text = watch[1]
		value.text = str(watch[0].get(watch[1]))
