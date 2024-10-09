extends Area2D
class_name Ball
const DEFUALT_SPEED = 200.0
var speed = 0
var speedIncrement = 25.0
var direction = Vector2.LEFT
var startPosition

@onready var _screen_size_x = get_viewport_rect().size.x
@onready var timer:Timer = $Timer

signal scorePlayer
signal scoreCPU

func _ready():
	startPosition = position


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			reset()


func _process(delta):
	position += speed * delta * direction

	if position.x < -_screen_size_x/2:
		scoreCPU.emit()
	elif position.x > _screen_size_x/2:
		scorePlayer.emit()


func _start():
	speed = DEFUALT_SPEED


func reset():
	direction = Vector2.LEFT
	position = startPosition
	speed = 0
	timer.start(1)


func speed_increment():
	speed += speedIncrement
