extends CanvasLayer

@export var basic_button: Button
@export var resource_button: Button

func _ready():
	basic_button.pressed.connect(_load_basic_scene)
	resource_button.pressed.connect(_load_resource_scene)


func _load_basic_scene():
	get_tree().change_scene_to_file("res://levels/basic.tscn")


func _load_resource_scene():
	get_tree().change_scene_to_file("res://levels/resource_level.tscn")


func _input(event):
	if event.is_action_pressed('quit'):
		get_tree().quit()
