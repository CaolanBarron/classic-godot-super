extends Control

func loadRegularLevel():
	get_tree().change_scene_to_file("res://basic/levels/BasicPong.tscn")
	


func loadHardcoreLevel():
	get_tree().change_scene_to_file("res://hardcore/levels/HardcoreIntro.tscn")
