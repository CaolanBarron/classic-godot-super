extends Area2D
class_name UFO

var _target_location: Vector2
var speed:int = 200
var buffer:int = 10

@onready var bullet_cooldown: Timer = $BulletCooldown

var ufo_bullet_scene = preload("res://objects/ufo_bullet.tscn")
var ufo_die_animation = preload("res://objects/ufo_explosion.tscn")

func _ready():
	area_entered.connect(_area_entered)
	_find_random_location()
	bullet_cooldown.timeout.connect(_fire_bullet)
# When it spawns in pick a random spot,
# When it reaches that spot pick a new random spot
# Fire bullets randomly


func _find_random_location():
	var size = get_viewport_rect().size
	_target_location = Vector2(randi_range(-size.x/2, size.x/2), randi_range(-size.y/2, size.y/2))


func _physics_process(delta):
	position = position.move_toward(_target_location, delta * speed)
	if position.distance_to(_target_location) < buffer:
		_find_random_location()


func _fire_bullet():
	var instance  =  ufo_bullet_scene.instantiate()
	get_parent().add_child(instance)
	instance.position = position


func _area_entered(area):
	if area is PlayerBullet:
		SignalBus.increase_score.emit(100)
		_die()

func _die():
	var instance = ufo_die_animation.instantiate()
	get_parent().add_child(instance)
	instance.position = global_position
	queue_free()
