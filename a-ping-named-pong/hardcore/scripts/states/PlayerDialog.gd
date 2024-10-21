extends State
class_name PlayerDialog

@export var body: CharacterBody2D

func _ready():
	SignalBus.end_dialogue.connect(_on_dialogue_finished)

func Process(_delta):
	pass

func Physics_process(delta):
	body.position = body.position.move_toward(body.starting_position, body.MOVE_SPEED * delta)


func Enter():
	pass


func Exit():
	pass


func _on_dialogue_finished():
	if body.enemy_will_malfunction:
		Transitioned.emit(self, 'MoveHorizontal')
	else:
		Transitioned.emit(self, 'MoveVertical')
