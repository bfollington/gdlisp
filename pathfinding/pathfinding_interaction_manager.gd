extends Node2D

onready var parent: Actor = get_parent() as Actor

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	parent.connect("message_handled", self, "_on_message")

func _on_message(msg):
	match msg.type:
		"destination_picked":
			PathfindingMessages.validate_destination_picked(msg.payload)
			parent.message_bus.broadcast("find_path", { "destination": msg.payload.destination })

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
