extends Node2D

var ufo_scene = preload("res://objects/ufo.tscn")
var screen_buffer:int = 32

@onready var spawn_cooldown = $SpawnCooldown 

func _ready():
	spawn_cooldown.timeout.connect(_spawn_asteroid)


func _spawn_asteroid():
	var random_side = randi_range(1,4)
	var random_point:Vector2
	var screen_size = get_viewport_rect().size
	screen_size.x += 60
	screen_size.y += 60
	match random_side:
		1:
			random_point = \
			Vector2(-screen_size.x/2, randf_range(-screen_size.y/2,screen_size.y/2))
		2:
			random_point = \
			Vector2(screen_size.x/2, randf_range(-screen_size.y/2,screen_size.y/2))
		3:
			random_point = \
			Vector2( randf_range(-screen_size.x/2,screen_size.x/2),-screen_size.y/2)
		4:
			random_point = \
			Vector2( randf_range(-screen_size.x/2,screen_size.x/2),screen_size.y/2)
	
	var instance = ufo_scene.instantiate()
	instance.position = random_point
	get_parent().add_child.call_deferred(instance)
	
	spawn_cooldown.start(randf_range(10, 25))
