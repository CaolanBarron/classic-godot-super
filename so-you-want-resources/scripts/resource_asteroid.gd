extends CharacterBody2D
class_name ResourceAsteroid

# Asteroid needs to:
# Start moving in a random direction at a random speed
# Start rotating in a random direction at a random speed

var drops_resources:bool = false

@export var max_move_speed: int = 3
var min_move_speed: int = 1
var max_rotate_speed: float = 3
var min_rotate_speed: float = -3

var random_direction:= Vector2.ZERO
var movement_speed: int = 0
var rotation_speed:int = 0

var stage = 1

var asteroid_scene = preload("res://objects/resource_asteroid.tscn")

@onready var resource_manager: ResourceManager = $"../ResourceManager"
@onready var area = $Area2D

func _ready():
	print(resource_manager)
	area.area_entered.connect(_area_entered)
	_initiate_asteroid()


func _area_entered(area):
	if area is PlayerBullet:
		queue_free()
		
		match stage:
			1:
				SignalBus.increase_score.emit(20)
			2:
				SignalBus.increase_score.emit(40)
			3:
				SignalBus.increase_score.emit(60)
			4:
				SignalBus.increase_score.emit(80)
		
		if stage > 2 && drops_resources:
			resource_manager.insert_resource(position)
			return
		if stage > 3: return
		for n in randi_range(1,2):
			var instance = asteroid_scene.instantiate()
			get_parent().call_deferred('add_child',instance)
			if drops_resources: instance.drops_resources = true
			instance.position = position
			instance.stage =  stage + 1
			instance.scale = scale
			instance.scale.x -= 0.2
			instance.scale.y -= 0.2


func _initiate_asteroid():
	#random_direction = Vector2(randf_range(250, -250),randf_range(250, -250)).normalized()
	var point = Vector2(randi_range(-200, 200), randi_range(-200, 200))
	random_direction =\
	 position.direction_to(point)
	movement_speed = randi_range(min_move_speed, max_move_speed)
	rotation_speed = randf_range(min_rotate_speed, max_rotate_speed)
	velocity = random_direction * movement_speed
	
	
func _physics_process(delta):
	move_and_collide(velocity)
	rotate(rotation_speed * delta)
	if Utils.is_outside_screen(position, 100):
		queue_free()


