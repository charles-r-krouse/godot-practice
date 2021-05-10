extends Label

var accum = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	accum += delta
	text = str(accum)
