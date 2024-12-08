extends Node2D

var init_round: int = 0
var current_round: int = init_round
@export var init_asteroid_count: int
var asteroid_count: int  = init_asteroid_count
var init_asteroid_max_speed: int = 10
var asteroid_max_speed: int = init_asteroid_max_speed

@export var init_ufo_count: int
var ufo_count: int = init_ufo_count
var init_ufo_max_speed: int = 10
var ufo_max_speed: int = init_ufo_max_speed

@export var wave_cooldown_time = 10

var asteroid_scene = preload("res://objects/resource_asteroid.tscn")

@onready var asteroid_timer: Timer = $AsteroidSpawnCooldown
@onready var ufo_timer: Timer = $UFOSpawnCooldown
@onready var wave_cooldown_timer: Timer = $WaveCooldown
@onready var new_round_conditions_timer: Timer = $WaitNewRoundConditions

func _ready():
	asteroid_timer.timeout.connect(_asteroid_timer_finished)
	ufo_timer.timeout.connect(_ufo_timer_finished)
	wave_cooldown_timer.timeout.connect(_next_round)
	new_round_conditions_timer.timeout.connect(_check_round_finished)
	SignalBus.end_shopping.connect(_next_round)
	_start_waves()

func _start_waves():
	_reset_wave_values()
	print('Round: ' + str(current_round))
	asteroid_timer.start(randf_range(1, 2))
	ufo_timer.start(randf_range(1, 4))


func _next_round():
	current_round += 1
	print('Round: ' + str(current_round))
	asteroid_count = init_asteroid_count
	ufo_count = init_ufo_count
	asteroid_timer.start(randf_range(1, 2))
	ufo_timer.start(randf_range(1, 4))

func _reset_wave_values():
	asteroid_count = init_asteroid_count
	asteroid_max_speed = init_asteroid_max_speed
	ufo_count = init_ufo_count
	ufo_max_speed = init_ufo_max_speed
	
	current_round = init_round

func _check_round_finished():
	if asteroid_count > 0 and ufo_count > 0: return
	var existing_enemies:Array = get_tree().get_nodes_in_group('wave_enemy')
	if existing_enemies.size() != 0:
		print('There are still enemies remaining')
		new_round_conditions_timer.start(3)
		return
	print(current_round)
	if current_round % 3 == 0: #and current_round != 0:
		print('Starting shopping round')
		SignalBus.start_shopping.emit()
		return
		
	print('Starting new wave cooldown')
	wave_cooldown_timer.start(wave_cooldown_time)


func _process(delta):
	pass


func _asteroid_timer_finished():
	# TODO: do checks here if any more asteroids should be spawned this round
	if asteroid_count > 0:
		_spawn_asteroid()
		asteroid_count -= 1
		asteroid_timer.start(randf_range(1, 2))
	else:
		_check_round_finished()


func _spawn_asteroid():
	var random_side = randi_range(1,4)
	var random_point:Vector2
	var screen_size = get_viewport_rect().size
	screen_size.x += 60
	screen_size.y += 60
	match random_side:
		1:
			random_point = \
			Vector2(-screen_size.x/2, randf_range(-screen_size.y/2,screen_size.y/2))
		2:
			random_point = \
			Vector2(screen_size.x/2, randf_range(-screen_size.y/2,screen_size.y/2))
		3:
			random_point = \
			Vector2( randf_range(-screen_size.x/2,screen_size.x/2),-screen_size.y/2)
		4:
			random_point = \
			Vector2( randf_range(-screen_size.x/2,screen_size.x/2),screen_size.y/2)
	
	var instance = asteroid_scene.instantiate()
	instance.position = random_point
	instance.drops_resources = true

	get_parent().add_child.call_deferred(instance)


func _ufo_timer_finished():
	pass
