extends Area2D
class_name PlayerBullet

var speed:int = 600
var direction = Vector2.ZERO

@onready var expiry_timer: Timer = $Expiry

func _ready():
	expiry_timer.timeout.connect(_expire_bullet)
	area_entered.connect(_area_entered)

func fire(direction, speed_modifier):
	self.direction = direction

func _physics_process(delta):
	position += direction * (speed * delta)
	global_position = Utils.wrap_object_outside_screen(global_position)

func _expire_bullet():
	queue_free()

func _area_entered(area):
	if area is Asteroid:
		queue_free()

func _find_spawn_point():
	var x:int
	var y:int
	pass
