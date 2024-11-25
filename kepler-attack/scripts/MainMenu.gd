extends Control

func load_basic_level():
	get_tree().change_scene_to_file("res://world.tscn")


func load_kepler_mode():
	get_tree().change_scene_to_file("res://levels/KeplerMode.tscn")
