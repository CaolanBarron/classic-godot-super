extends Area2D


const SPEED = 200.0
@onready var _screen_size_y = get_viewport_rect().size.y
@onready var ball = %Ball
# Get a reference to the global_ball 
# (maybe do the thing where you defer if not created )

func _physics_process(delta):
	# If the ball is above the paddle move upwards
	var range
	if ball.position.y > position.y:
		range = ball.position.y - position.y
	else:
		range = position.y - ball.position.y
	
	if range < 5: return
	
	if ball.position.y > position.y:
			position.y = clamp(position.y + 1 * SPEED * delta, -215, _screen_size_y / 2 - 50)
	# If the ball is below the paddle move downwards
	else:
			position.y = clamp(position.y + -1 * SPEED * delta, -215, _screen_size_y / 2 - 50)


func _on_area_entered(area):
	if area.name == 'Ball':
		area.direction = area.direction * Vector2.LEFT
		area.direction.y = RandomNumberGenerator.new().randf_range(-1.00, 1.00)
		area.speed_increment()
	
