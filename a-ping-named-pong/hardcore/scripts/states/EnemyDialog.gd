extends State
class_name EnemyDialog

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
	Transitioned.emit(self, 'Idle')
