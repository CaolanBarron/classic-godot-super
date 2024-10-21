extends Node2D

var player_score : int = 0
var enemy_score  : int  = 0
var enemy_malfunctioned := false
@onready var player_label = %PlayerScore
@onready var enemy_label = %EnemyScore
@onready var dialog_manager : DialogManager = $DialogManager
@onready var player_block : CollisionShape2D = $Walls/PlayerBlock/CollisionShape2D

func playerScored():
	player_score += 1
	dialog_manager.show_messages(
		[
			'....',
			'....Ummm',
			'That doesnt count, my technology malfunctioned!',
			'Go get the ball, this shouldnt take me too long to fix...'
		]
	)
	player_label.text = str(player_score)
	if enemy_malfunctioned:
		player_block.disabled = false


func enemyScored():
	enemy_score += 1
	enemy_label.text = str(enemy_score)
	if enemy_score == 3:
		SignalBus.malfunction_teleportation.emit()
		enemy_malfunctioned = true

func _ready():
	dialog_manager.show_messages(
		[
			'My teleportation technology is unbeatable',
			'Score one point against me and you win' 
		]
	)
