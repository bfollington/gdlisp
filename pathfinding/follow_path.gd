extends Node2D
class_name PathFollower

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var path := PoolVector2Array() setget set_path
export var speed := 400.0

onready var parent: Actor = get_parent() as Actor

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	parent.connect("message_handled", self, "_on_message")
	
func _on_message(msg):
	match msg.type:
		"follow_path":
			PathfindingMessages.validate_follow_path(msg.payload)
			set_path(msg.payload.path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = delta * speed
	move_along_path(distance)
	
func move_along_path(distance: float) -> void:
	var start_point = parent.position
	for _i in range(path.size()):
		var dist_to_next = start_point.distance_to(path[0])
		if distance <= dist_to_next and distance >= 0.0:
			parent.position = start_point.linear_interpolate(path[0], distance / dist_to_next)
			break
		distance -= dist_to_next
		start_point = path[0]
		path.remove(0)

func set_path(val: PoolVector2Array) -> void:
	path = val
	if val.size() == 0:
		return
	set_process(true)
