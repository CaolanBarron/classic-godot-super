extends Area2D

@export var speed = 5.0
var bullet_scene = preload("res://objects/player_bullet.tscn")

func _input(event):
	if Input.is_action_just_pressed('shoot'):
		var instance = bullet_scene.instantiate()
		instance.position = position
		get_parent().add_child(instance)
		
func _physics_process(delta):
	if Input.is_action_pressed('move-left'):
		if position.x - 16 > -(get_viewport_rect().size.x / 2):
			position.x -= speed * delta
	elif Input.is_action_pressed('move-right'):
		if position.x + 16 < get_viewport_rect().size.x / 2:
			position.x += speed * delta
