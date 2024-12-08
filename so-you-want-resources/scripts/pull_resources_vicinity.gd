extends Area2D

@export var stationary: bool = false
@export var force_power: int

var amount_being_pulled: int = 0
@onready var sprite:AnimatedSprite2D = $PullCircleDisplay

func _ready():
	if stationary:
		sprite.visible = true


func _process(delta):
	if stationary:
		_pull_resources()
		return
	
	if Input.is_action_pressed('pull_resources'):
		sprite.visible = true
		_pull_resources()
	else:
		sprite.visible = false


func _pull_resources():
	var nearby = get_overlapping_areas()
	amount_being_pulled = nearby.size()
	if nearby.size() == 0: return
	for resource in nearby:
		var resource_parent: RigidBody2D = resource.get_parent()
		var direction =\
			resource_parent.global_position.direction_to(global_position)
		resource_parent.apply_force(direction * force_power)
