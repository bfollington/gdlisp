extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var out = GdLisp.eval(GdLisp.parse("(do (define r 10) (* pi (* r r)))"), Env.default())
	var out = GdLisp.eval(GdLisp.parse("""
	(do
		(define r 10)
		(if (> (* r r) 99)
			15
			35))
	"""), Env.default())
	print(out)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotate(0.1)
