extends Area2D

@export
var locked_door: StaticBody2D

var destroyed: bool = false

@onready var turret_sprite: Sprite2D = $TurretSprite
@onready var explosion_sprite = $ExplosionSprite
@onready var timer = $BulletSpawner
var bullet_object = load("res://hardcore/objects/bullet.tscn")
@onready var bullet_spawn_point: Node2D = $BulletSpawnPoint

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_bullet: Bullet

func _process(delta):
	
	if destroyed:
		locked_door.position = locked_door.position.move_toward(Vector2(2816, -39), delta * 300)
	#print(current_bullet)
	if !current_bullet: return
	#print(position.distance_to(current_bullet.position))
	if position.distance_to(current_bullet.position) > 3110:
		current_bullet.queue_free()
		


func _on_area_entered(area):
	if area.name == 'Bullet':
		animation_player.current_animation = 'turret'


func _on_bullet_spawner_timeout():
	if !current_bullet:
		current_bullet = bullet_object.instantiate()
		current_bullet.position = bullet_spawn_point.position
		add_child(current_bullet)

func cause_explosion():
	timer.stop()
	current_bullet.queue_free()
	turret_sprite.visible = false
	explosion_sprite.visible = true

func end_explosion():
	explosion_sprite.visible = false
	destroyed = true
