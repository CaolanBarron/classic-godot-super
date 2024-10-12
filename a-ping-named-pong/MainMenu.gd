extends Control

func loadRegularLevel():
	get_tree().change_scene_to_file("res://levels/BasicPong.tscn")
	


func loadHardcoreLevel():
	get_tree().change_scene_to_file("res://levels/HardcoreIntro.tscn")
