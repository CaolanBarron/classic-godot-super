extends CharacterBody2D

@export var rotation_speed: float
@export var acceleration_force: int
@export var velocity_decrease: float

func _process(delta):
	pass


func _physics_process(delta):
	print(velocity)
	velocity = lerp(velocity, Vector2.ZERO, delta * velocity_decrease)
	var rotation_direction = Input.get_axis("turn_left", "turn_right")
	rotate(rotation_direction * rotation_speed)
	
	if Input.is_action_pressed("accelerate"):
		var facing = Vector2(0,-1).rotated(rotation)
		velocity += facing * (acceleration_force * delta)
	move_and_collide(velocity)
	#clamp()
