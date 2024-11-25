extends HBoxContainer

func _ready():
	SignalBus.reduce_life.connect(_reduce_life)
	SignalBus.lives_reset.connect(_reset_life)


func _reduce_life():
	var life_taken:= false
	var life_subsituted:= false
	for child in get_children():
		if child is TextureRect and child.visible:
			child.visible = false
			life_taken = true
		elif child is MarginContainer and !child.visible:
			child.visible = true
			life_subsituted = true
		if life_taken and life_subsituted:
			return


func _reset_life():
	for child in get_children():
		if child is TextureRect:
			child.visible = true
		elif child is MarginContainer:
			child.visible = false
