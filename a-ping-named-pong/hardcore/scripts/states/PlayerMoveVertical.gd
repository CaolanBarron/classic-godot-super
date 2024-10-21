extends State
class_name PlayerMoveVertical

@export var player: Player

var lock_x 
var direction: Vector2 = Vector2.ZERO

func _ready():
	SignalBus.start_dialogue.connect(_on_dialogue_entered)

func Enter():
	lock_x = player.position.x


func Process(_delta):
	if Input.is_action_just_pressed("transition-move-state") and !player.transition_input_locked:
		Transitioned.emit(self, "MoveHorizontal")
	
	direction = Vector2(0, Input.get_axis("move-up", "move-down"))
	player.position.x = lock_x


func Physics_process(delta):
	player.move_and_collide(direction * player.MOVE_SPEED * delta)


func _on_dialogue_entered():
	Transitioned.emit(self, 'Dialog')
