extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play('win_cutscene')


func animation_ended():
	get_tree().quit()
