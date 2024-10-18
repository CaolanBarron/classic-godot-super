extends CharacterBody2D
class_name Ball

const DEFUALT_SPEED = 200.0
var speed = 0
var speed_increment_value = 25.0
var start_position
var previous_x_pos = 0.00
var previous_x_pos_list : Array = []

@onready var _screen_size_x = get_viewport_rect().size.x
@onready var timer:Timer = $Timer
@onready var raycast: RayCast2D = $RayCast2D
@onready var raycast_display: Line2D = $Line2D

signal scorePlayer
signal scoreCPU

func _ready():
	start_position = position


func _process(_delta):
	# TODO: This code bounces the ball if it hasnt moved in a few frames stop it getting stuck
	# TODO: clean it up
	previous_x_pos_list.append(position.x)
	if previous_x_pos_list.size() > 5:
		previous_x_pos_list.pop_front()
		
	var distance_traveled = previous_x_pos_list.max() - previous_x_pos_list.min()
	if distance_traveled < 3 && distance_traveled != 0:

		if position.x < 0:
			velocity = velocity.bounce(Vector2.RIGHT)
			velocity.x += 1
		else:
			velocity = velocity.bounce(Vector2.LEFT)
			velocity.x -= 1
	
	if position.x < -_screen_size_x/2:
		scoreCPU.emit()
		reset()
	elif position.x > _screen_size_x/2:
		scorePlayer.emit()
		reset()


func _physics_process(delta):
	previous_x_pos = position.x
	velocity = velocity.normalized() * speed * delta 
	move_and_collide(velocity)


func start_movement():
	speed = DEFUALT_SPEED
	previous_x_pos = position.x
	velocity = Vector2(-1, RandomNumberGenerator.new().randf_range(-1.0, 1.0))


func reset():
	position = start_position
	previous_x_pos = position.x
	speed = 0
	velocity = Vector2.ZERO
	timer.start(1)


func speed_increment():
	speed += speed_increment_value


func collision_detected(area:Area2D):
	bounce(area.global_position)


func bounce(pos: Vector2):
	raycast.target_position = pos
	raycast.force_raycast_update()
	var normal = raycast.get_collision_normal()
	velocity = velocity.bounce(normal.normalized())
	var rng = RandomNumberGenerator.new()
	var randomAlteration = rng.randf_range(-0.8, 0.8)
	velocity = Vector2(velocity.x, velocity.y + randomAlteration)
	speed_increment()
