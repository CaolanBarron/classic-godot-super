extends Area2D
class_name Alien

signal hit_wall
signal destroyed
signal reached_goal

var alien_bullet_scene = preload("res://objects/alien_bullet.tscn")

func destroy():
	destroyed.emit(self)
	SignalBus.increase_score.emit()
	queue_free()

func _physics_process(delta):
	if global_position.x + 16 > get_viewport_rect().size.x / 2 \
	or global_position.x - 16 < -(get_viewport_rect().size.x / 2): 
		hit_wall.emit()

func _process(delta):
	if global_position.y + 16 >= get_viewport_rect().size.y / 2:
		reached_goal.emit()


func fire():
	var instance = alien_bullet_scene.instantiate()
	instance.position = global_position
	get_parent().get_parent().add_child(instance)
