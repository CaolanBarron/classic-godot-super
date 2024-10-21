extends State
class_name PlayerMoveHorizontal

@export var player: Player

func _ready():
	SignalBus.start_dialogue.connect(_on_dialogue_entered)


func Process(_delta):
	if Input.is_action_just_pressed("transition-move-state") and !player.transition_input_locked:
		Transitioned.emit(self, "MoveVertical")
	


func Physics_process(delta):
	player.velocity.y += player.gravity * delta
	
	var direction = Input.get_axis("move-left", "move-right")
	player.velocity.x = direction * player.MOVE_SPEED
	
	player.move_and_slide()


func _on_dialogue_entered():
	Transitioned.emit(self, 'Dialog')
