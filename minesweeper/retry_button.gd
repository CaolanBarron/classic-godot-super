extends Button

func _ready():
	pressed.connect(_retry)

func _retry():
	get_tree().change_scene_to_file("res://game.tscn")
