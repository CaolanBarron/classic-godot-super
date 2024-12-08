extends CharacterBody2D
class_name Player

@export var rotation_speed: float
@export var acceleration_force: int
@export var velocity_decrease: float
@export var respawn_time:int
@export var fire_cooldown: float 

var is_alive:bool = true
var lives = 3

var bullet_scene = preload("res://objects/player_bullet.tscn")

@onready var upgrade_manager:UpgradeManager = $"../UpgradeManager"
@onready var upgrades: Node2D = $Upgrades
@onready var bullet_origin = $BulletOrigin
@onready var player_collision:Area2D = $PlayerCollision
@onready var rocket_animation: AnimatedSprite2D = $RocketBoostAnimation
@onready var player_sprite:Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $DeathAnimation/AnimationPlayer
@onready var respawn_timer:Timer = $Timers/RespawnTimer
@onready var invulnabilty_timer:Timer = $Timers/InvulnabiltiyTimer
@onready var invulnabilty_display_timer:Timer = $Timers/InvulnabilityDisplayTimer
@onready var bullet_cooldown_timer: Timer = $Timers/BulletCooldownTimer

func _ready():
	player_collision.area_entered.connect(_area_entered)
	respawn_timer.timeout.connect(_respawn)
	invulnabilty_display_timer.timeout.connect(_flash_player)

func _input(event):
	if event.is_action_pressed('quit'):
		get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _physics_process(delta):
	# Run all upgrades
	if upgrade_manager:
		upgrade_manager.reset_modifiers()
	if upgrades.get_child_count() > 0:
		for upgrade: Upgrade in upgrades.get_children():
			upgrade.execute()
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


func _process(delta):
	if !is_alive: return
	if Input.is_action_pressed("shoot") and bullet_cooldown_timer.is_stopped():
		var instance: PlayerBullet = bullet_scene.instantiate() 
		instance.position = bullet_origin.global_position
		get_parent().add_child(instance)
		instance.rotation = rotation
		instance.scale += instance.scale * upgrade_manager.bullet_size_modifier
		var direction = Vector2(0,-1).rotated(rotation)
		instance.fire(direction, velocity.length())
		var final_cooldown_time =\
			fire_cooldown + upgrade_manager.bullet_fire_rate_modifier
		bullet_cooldown_timer\
		.start(clampf(final_cooldown_time, 0.1, 1))


func _area_entered(area):
	if area is Asteroid && invulnabilty_timer.is_stopped():
		_die()
	if area.get_parent() is ResourceAsteroid && invulnabilty_timer.is_stopped():
		_die()
	if area is UFO && invulnabilty_timer.is_stopped():
		_die()
	if area is UfoBullet && invulnabilty_timer.is_stopped():
		_die()


func _die():
	player_collision.set_deferred('monitoring', false)
	player_collision.set_deferred('monitorable', false)
	SignalBus.remove_chance.emit()
	respawn_timer.start(respawn_time)
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


func add_upgrade(upgrade: Upgrade):
	upgrades.add_child(upgrade)
