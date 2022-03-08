class_name Channel

var name: String
var queue = []

func _init(channel_name):
	name = channel_name

func send(msg):
	queue.append(msg)

func peek():
	if len(queue) > 0:
		return queue[0]
	else:
		return null

func pop():
	var item = peek()
	if item != null:
		queue.remove(0)

	return item

func length():
	return len(queue)
