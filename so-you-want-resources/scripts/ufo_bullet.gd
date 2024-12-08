extends Area2D
class_name UfoBullet

var speed:int = 250
var direction = Vector2.ZERO
@onready var expiry_timer: Timer = $Expiry

func _ready():
	expiry_timer.timeout.connect(_expire_bullet)
	area_entered.connect(_area_entered)
	direction = global_position.direction_to(_find_random_location())

func _physics_process(delta):
	position += direction * (speed * delta)


func _expire_bullet():
	queue_free()


func _area_entered(area):
	if area is Asteroid:
		queue_free()

func _find_random_location() -> Vector2:
	var size = get_viewport_rect().size
	return Vector2(randi_range(-size.x/2, size.x/2), randi_range(-size.y/2, size.y/2))
