extends Control

func loadRegularLevel():
	get_tree().change_scene_to_file("res://Levels/BasicPong.tscn")
	


func loadHardcoreLevel():
	get_tree().change_scene_to_file("res://Levels/HardcoreIntro.tscn")
