class_name PackagedMessage

var id: String
var type: String
var payload: Dictionary
var _meta: Dictionary

func _init(type, payload):
	self.id = UUID.v4()
	self.type = type
	self.payload = payload
