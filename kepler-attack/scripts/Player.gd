extends Area2D
class_name Player

var bullet_scene = preload("res://objects/player_bullet.tscn")

@onready var bullet_fire_cooldown: Timer = $Timer
@export var speed = 5.0
var lives := 3
var _starting_position: Vector2
var active_bullets: Array[PlayerBullet] = []

var player_active: = true

func _ready():
	_starting_position = position
	SignalBus.reset_player.connect(_reset_player)
	SignalBus.activate_player.connect(_activate_player)
	SignalBus.deactivate_player.connect(_deactivate_player)


func _input(event):
	if Input.is_action_just_pressed('quit'):
		get_tree().change_scene_to_file("res://levels/MainMenu.tscn")
	if !player_active: return
	if Input.is_action_just_pressed('shoot') && bullet_fire_cooldown.is_stopped():
		var instance = bullet_scene.instantiate()
		instance.position = position
		get_parent().add_child(instance)
		active_bullets.push_back(instance)
		bullet_fire_cooldown.start()


func _physics_process(delta):
	if !player_active: return
	if Input.is_action_pressed('move-left'):
		if position.x - 16 > -(get_viewport_rect().size.x / 2):
			position.x -= speed * delta
	elif Input.is_action_pressed('move-right'):
		if position.x + 16 < get_viewport_rect().size.x / 2:
			position.x += speed * delta


func _activate_player():
	player_active = true


func _deactivate_player():
	player_active = false


func _reset_player():
	position = _starting_position
	lives = 3
	SignalBus.lives_reset.emit()
	for b in active_bullets:
		if is_instance_valid(b):
			b.queue_free()
	active_bullets.clear()
	_activate_player()


func got_hit():
	lives -=1
	SignalBus.reduce_life.emit()
	if lives <= 0:
		SignalBus.aliens_win.emit()
