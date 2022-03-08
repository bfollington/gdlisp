class_name PathfindingMessages

static func destination_picked(destination: Vector2):
	return PackagedMessage.new("destination_picked", { "destination": destination })
	
static func validate_destination_picked(payload):
	assert(payload.has("destination"))
	
static func find_path(destination: Vector2):
	return PackagedMessage.new("find_path", { "destination": destination })

static func validate_find_path(payload):
	assert(payload.has("destination"))

	
static func follow_path(path: PoolVector2Array):
	return PackagedMessage.new("follow_path", { "path": path })

static func validate_follow_path(payload):
	assert(payload.has("path"))
