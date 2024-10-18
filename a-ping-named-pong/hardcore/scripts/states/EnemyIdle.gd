extends State
class_name EnemyIdle

@export var enemy: TeleportEnemy
var starting_position

func _ready():
	starting_position = enemy.position

func Start():
	starting_position = enemy.position

func Exit():
	pass


func Process(_delta):
	if enemy.ball.position.x > enemy.ball.previous_x_pos:
		Transitioned.emit(self, 'Teleport')


func Physics_process(delta):
	enemy.position = enemy.position.move_toward(starting_position, enemy.MOVE_SPEED * delta)
