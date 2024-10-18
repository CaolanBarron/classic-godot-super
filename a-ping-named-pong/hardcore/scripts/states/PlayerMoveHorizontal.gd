extends State
class_name PlayerMoveHorizontal

@export var player: Player


var direction: Vector2 = Vector2.ZERO

func Enter():
	pass


func Process(_delta):
	if Input.is_action_just_pressed("transition-move-state") and !player.transition_input_locked:
		Transitioned.emit(self, "MoveVertical")
	
	direction = Vector2(Input.get_axis("move-left", "move-right"), 0)
	

func Physics_process(delta):
	player.move_and_collide(direction * player.SPEED * delta)
