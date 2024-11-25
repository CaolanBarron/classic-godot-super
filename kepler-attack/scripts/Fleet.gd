extends Node2D
class_name Fleet

var alien_scene = preload("res://objects/alien.tscn")
var kepler_alien_scene = preload("res://objects/kepler_alien.tscn")
@onready var wall_hit_cooldown:Timer = $WallHitCooldown
@onready var fire_rate_cooldown:Timer = $FireRate

@export var rows: int
@export var columns: int
@export var spacing: int
@export var kepler_mode :bool =  false

var game_active := false
var _direction := 1
var _base_speed := 30
var _current_speed := _base_speed
var _speed_step := 5
var _vertical_move := 10
var _aliens: Array[Alien] = []
var starting_position: Vector2



func _ready(): 
	starting_position = position
	SignalBus.start_game.connect(instantiate_aliens)
	fire_rate_cooldown.timeout.connect(_alien_fire)
	


func instantiate_aliens():
	position = starting_position
	_current_speed = _base_speed
	# Thanks youtube man this is probably very easy but i cant think of it right now
	for row in rows:
		var width = spacing * (columns - 1)
		var height = spacing * (rows -1)
		var centering = Vector2(-width/2, -height/2)
		var row_position = Vector2(centering.x, centering.y + (row * spacing))
		for column in columns:
			var alien:Alien
			if kepler_mode:
				alien = kepler_alien_scene.instantiate()
			else:
				alien = alien_scene.instantiate()
			alien.hit_wall.connect(_hit_wall)
			alien.destroyed.connect(_alien_destroyed)
			alien.reached_goal.connect(_aliens_win)
			_aliens.push_back(alien)
			add_child(alien)
			var position = row_position
			position.x += column * spacing
			alien.position = position
	game_active = true
	fire_rate_cooldown.start()


func _physics_process(delta):
	if game_active:
		position.x += _direction * (_current_speed * delta)


func _hit_wall():
	if !wall_hit_cooldown.is_stopped(): return
	
	_direction = _direction * -1
	position.y += _vertical_move
	wall_hit_cooldown.start()


func _alien_destroyed(alien):
	_current_speed += _speed_step
	_aliens.erase(alien)


func _alien_fire():
	var alien = _aliens.pick_random()
	if is_instance_valid(alien):
		alien.fire()


func _process(delta):
	# Debug label display
	if !game_active: return
	
	if _aliens.size() == 0:
		_all_aliens_destroyed()


func _aliens_win():
	game_active = false
	_aliens.clear()
	for n in get_children():
		if n is Timer: continue
		remove_child(n)
		n.queue_free()
	SignalBus.aliens_win.emit()
	SignalBus.reset_score.emit()



func _all_aliens_destroyed():
	game_active = false
	SignalBus.all_aliens_destroyed.emit()
	SignalBus.reset_score.emit()
