extends CanvasLayer

@export var button: Button

func _ready():
	button.pressed.connect(_try_again)


func _try_again():
	get_tree().change_scene_to_file("res://basic.tscn")
	
