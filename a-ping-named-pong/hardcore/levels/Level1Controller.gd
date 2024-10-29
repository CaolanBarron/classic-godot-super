extends Node2D

@export var player :Player

func _ready():
	player.transition_input_locked = false
