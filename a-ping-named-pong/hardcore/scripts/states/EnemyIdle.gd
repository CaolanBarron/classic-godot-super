extends State
class_name EnemyIdle

@export var enemy: TeleportEnemy

func _ready():
	SignalBus.start_dialogue.connect(_on_dialogue_entered)

func Exit():
	pass


func Process(_delta):
	if enemy.ball.position.x > enemy.ball.previous_x_pos:
		Transitioned.emit(self, 'Teleport')


func Physics_process(delta):
	enemy.position = enemy.position.move_toward(enemy.starting_position, enemy.MOVE_SPEED * delta)

func _on_dialogue_entered():
	Transitioned.emit(self, 'Dialog')
