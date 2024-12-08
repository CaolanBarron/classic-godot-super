extends CanvasLayer

@export var button: Button

@export var resource_mode:bool

func _ready():
	button.pressed.connect(_try_again)


func _try_again():
	if resource_mode:
		get_tree().change_scene_to_file("res://levels/resource_level.tscn")
		return
	get_tree().change_scene_to_file("res://levels/basic.tscn")
	
