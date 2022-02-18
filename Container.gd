extends Control

onready var text = $Panel/TextEdit
onready var output = $Panel/Output

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	var out = GdLisp.eval(GdLisp.parse(text.text), Env.default())
	output.text = str(out)
	
