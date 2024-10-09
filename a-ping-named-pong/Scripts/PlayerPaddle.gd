extends Area2D

const SPEED = 300.0
@onready var _screen_size_y = get_viewport_rect().size.y


func _physics_process(delta):
	var direction = Input.get_axis("move-up", "move-down")
	position.y = clamp(position.y + direction * SPEED * delta, -215, _screen_size_y / 2 - 50)


func _on_area_entered(area):
	if area.name == 'Ball':
		area.direction = area.direction * Vector2.LEFT
		area.direction.y = RandomNumberGenerator.new().randf_range(-1.00, 1.00)
		area.speed_increment()
