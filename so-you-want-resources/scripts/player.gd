extends CharacterBody2D
class_name Player

@export var rotation_speed: float
@export var acceleration_force: int
@export var velocity_decrease: float
var is_alive:bool = true
var lives = 3

var bullet_scene = preload("res://objects/player_bullet.tscn")

@onready var bullet_origin = $BulletOrigin
@onready var player_collision:Area2D = $PlayerCollision
@onready var respawn_timer:Timer = $RespawnTimer
@onready var rocket_animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_sprite:Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var invulnabilty_timer:Timer = $InvulnabiltiyTimer
@onready var invulnabilty_display_timer:Timer = $InvulnabilityDisplayTimer

func _ready():
	player_collision.area_entered.connect(_area_entered)
	respawn_timer.timeout.connect(_respawn)
	invulnabilty_display_timer.timeout.connect(_flash_player)

func _input(event):
	if !is_alive: return
	if Input.is_action_just_pressed("shoot"):
		var instance: PlayerBullet = bullet_scene.instantiate() 
		instance.position = bullet_origin.global_position
		get_parent().add_child(instance)
		instance.rotation = rotation
		var direction = Vector2(0,-1).rotated(rotation)
		instance.fire(direction, velocity.length())
	if event.is_action_pressed('quit'):
		get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _physics_process(delta):
	# slow player
	velocity = lerp(velocity, Vector2.ZERO, delta * velocity_decrease)
	if is_alive: 
		var rotation_direction = Input.get_axis("turn_left", "turn_right")
		rotate(rotation_direction * rotation_speed)
		
		if Input.is_action_pressed("accelerate"):
			rocket_animation.play('default')
			var facing = Vector2(0,-1).rotated(rotation)
			velocity += facing * (acceleration_force * delta)
		else:
			rocket_animation.stop()
			rocket_animation.frame = 1
		
	move_and_collide(velocity)
	global_position = Utils.wrap_object_outside_screen(global_position)


func _area_entered(area: Area2D):
	if area is Asteroid && invulnabilty_timer.is_stopped():
		_die()


func _die():
	player_collision.set_deferred('monitoring', false)
	player_collision.set_deferred('monitorable', false)
	SignalBus.remove_chance.emit()
	respawn_timer.start(4)
	is_alive = false
	player_sprite.visible = false
	animation_player.play('ship-explodes')
	rocket_animation.stop()
	rocket_animation.frame = 1
	lives -= 1
	if lives == 0:
		SignalBus.game_over.emit()

func _flash_player():
	if invulnabilty_timer.is_stopped():
		invulnabilty_display_timer.stop()
		visible = true
		return
	visible = !visible
	

func _respawn():
	player_collision.monitoring = true
	player_collision.monitorable = true
	is_alive = true
	player_sprite.visible = true
	animation_player.play('blank-parts')
	invulnabilty_timer.start()
	invulnabilty_display_timer.start()
	# When respawning check if area is clear if not then wait a second
	# Maybe if enoug respawn attempts fail reset the players position or find a free position
