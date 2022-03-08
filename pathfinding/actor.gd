extends Node2D
class_name Actor

export(NodePath) onready var message_bus = get_node(message_bus) as MessageBus
var actor_id = UUID.new()
var channel = Channel.new("actor/" + str(actor_id))

# In the future we may want a way to check the delivery method
	# That is, was this direct, via a channel or globally broadcast
signal message_received(msg)
signal message_handled(msg)
signal message_processed(msg)

# connects to a central messaging system for all actors
# generate an unique id to communicate with
# has a message queue
# listens for the process_message tick from the central system
# pops the stack, decides what to do (perform actions, send messages to others, make queries etc)
# repeat

# DEMO case
# central messaging system
# node that listens to mouse input
# sends message to pathfinding system to ask for a path
# pathfinding systems sends a message to actor to tell it the path
# actor completes task and processes the message
# all looks the same from the outside as it does right now


func _ready():
	message_bus.connect("message_broadcast", self, "_on_message_received_broadcast")
	message_bus.connect("message_sent_channel", self, "_on_message_received_channel")
	message_bus.connect("message_sent_target", self, "_on_message_received_target")

func _on_message_received_broadcast(msg):
	channel.send(msg)

func _on_message_received_channel(channel_id, msg):
	msg._meta["channel_id"] = channel_id
	channel.send(msg)

func _on_message_received_target(target_id, msg):
	if target_id == actor_id:
		channel.send(msg)

func process_messages():
	var head = channel.peek()
	if head == null: return

	emit_signal("message_handled", head)

	# we will need logic to wait for the sub-processors to signal
	# if they need us to wait before saying this message was processed

	match head.type:
		"test":
			print("WOAHHH TEST " + head.id + " " + head.type + " " + str(head.payload))

	channel.pop()
	emit_signal("message_processed", head)

func _process(_delta):
	process_messages()
