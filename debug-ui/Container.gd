extends Control

onready var text = $Panel/TextEdit
onready var output = $Panel/Output

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var history = []
var history_cursor = 0
var open = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel.visible = false
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("repl_toggle"):
		if open:
			$Panel.visible = false
		else:
			$Panel.visible = true
			text.grab_focus()
			
		open = !open

	
	if text.has_focus():
		if Input.is_action_just_pressed("repl_evaluate"):
			text.readonly = true
			_on_Button_pressed()
			text.readonly = false
		
		if Input.is_action_just_pressed("repl_prev"):
			text.text = history[history_cursor]
			history_cursor -= 1
			history_cursor = max(0, history_cursor)
			
		if Input.is_action_just_pressed("repl_next"):
			history_cursor += 1
			history_cursor = min(len(history) - 1, history_cursor)
			text.text = history[history_cursor]

func _on_Button_pressed():
	if len(text.text.strip_edges(true, true))  > 0:
		var out = GdLisp.eval(GdLisp.parse(text.text), Env.default())
		history.append(text.text.strip_edges(true, true))
		history_cursor = len(history) - 1
		
		output.text += "\n" + text.text.strip_edges(true, true) + "\n=> " + str(out)
		text.text = ""
		output.cursor_set_line(output.get_line_count() - 1)
		
