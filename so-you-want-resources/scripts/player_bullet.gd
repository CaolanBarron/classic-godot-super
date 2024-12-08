extends Area2D
class_name PlayerBullet

var speed:int = 600
var direction = Vector2.ZERO

@onready var expiry_timer: Timer = $Expiry

func _ready():
	expiry_timer.timeout.connect(_expire_bullet)
	area_entered.connect(_area_entered)

func fire(input_direction, _speed_modifier):
	direction = input_direction

func _physics_process(delta):
	position += direction * (speed * delta)
	global_position = Utils.wrap_object_outside_screen(global_position)

func _expire_bullet():
	queue_free()

func _area_entered(area):
	if area is Asteroid or area.get_parent() is ResourceAsteroid:
		queue_free()
	print(area.name)
	if area.name == 'Option1' or area.name == 'Option2' or area.name == 'Option3':
		queue_free()
