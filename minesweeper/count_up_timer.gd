extends Label

var time_elapsed := 0.0

func _process(delta):
	time_elapsed += delta
	text = str(time_elapsed).pad_decimals(0)
