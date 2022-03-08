extends Node2D
class_name MessageBus

signal message_broadcast(msg)
signal message_sent_channel(channel_id, msg)
signal message_sent_target(target_id, msg)

signal message_processed(msg)

var channels = {}
var broadcast_channel = Channel.new("broadcast")

func broadcast(msg_type, payload) -> void:
	var msg = PackagedMessage.new(msg_type, payload )
	
	broadcast_channel.send(msg)
	print("broadcast " + msg_type)
	
	emit_signal("message_broadcast", msg)

func send_channel(channel_id, msg_type, payload) -> void:
	var chan = channels[channel_id] if channels.has(channel_id) else Channel.new(channel_id)
	channels[channel_id] = chan

	var msg = PackagedMessage.new(msg_type, payload )
	
	chan.send(msg)
	emit_signal("message_sent_channel", channel_id, msg)

func send_target(target_id, msg_type, payload) -> void:
	var msg = PackagedMessage.new(msg_type, payload)
	
	emit_signal("message_sent_target", target_id, msg)

func message_processed(msg):
	emit_signal("message_processed", msg)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
