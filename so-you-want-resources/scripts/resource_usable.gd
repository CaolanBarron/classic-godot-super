extends RigidBody2D
class_name ResourceUsable

@onready var area_2d: Area2D = $ResourceUsableArea2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	area_2d.area_entered.connect(_area_entered)
	animated_sprite.animation_finished.connect(_animation_finished)


func _area_entered(area):
	if area is PlayerBullet:
		_start_destruction()

func _animation_finished():
	if animated_sprite.animation == 'destruction':
		queue_free()


func _start_destruction():
	animated_sprite.play('destruction')
	area_2d.set_deferred('monitoring', false)
	area_2d.set_deferred('monitorable', false)
