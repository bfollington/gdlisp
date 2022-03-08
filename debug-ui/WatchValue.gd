extends HBoxContainer

signal removed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_watched_value(label, value):
	$Label.text = str(label)
	$Value.text = str(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Remove_pressed():
	emit_signal("removed")
