extends WindowDialog

var logs = []
var row = preload("res://LogEntry.tscn")
var rows = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var ctrl = get_node("/root/GdLispGodotController")
	ctrl.connect("emit_log", self, "_on_log_capture")
	pass # Replace with function body.

func _on_log_capture(stream, values):
	show()
	logs.append({ "stream": stream, "values": values })

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(0, len(logs)):
		var entry = logs[i]
		if len(rows) - 1 < i:
			var new_row = row.instance()
			rows.append(new_row)
			$VBoxContainer.add_child(new_row)
		
		var r = rows[i]
		r.render(entry.values)
