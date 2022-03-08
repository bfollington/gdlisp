extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var watching = []
var row = preload("res://WatchValue.tscn")
var rows = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var ctrl = get_node("/root/GdLispGodotController")
	ctrl.connect("watch_value", self, "_on_value_watched")
	pass # Replace with function body.

func _on_value_watched(node, key):
	show()
	watching.append([node, key])

func _on_value_unwatched(idx, watch):
	var r = rows[0]
	var watch_idx = watching.find(watch)
	watching.remove(watch_idx)
	rows.remove(0)
	r.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(0, len(watching)):
		var watch = watching[i]
		if len(rows) - 1 < i:
			var new_row = row.instance()
			rows.append(new_row)
			$VBoxContainer.add_child(new_row)
			new_row.connect("removed", self, "_on_value_unwatched", [i, watch])
		
		var r = rows[i]
		r.update_watched_value(watch[1], watch[0].get(watch[1]))
