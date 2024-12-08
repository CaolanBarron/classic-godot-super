extends Node2D
class_name UfoExplosion

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("ufo-dies")


func animation_ended():
	queue_free()
