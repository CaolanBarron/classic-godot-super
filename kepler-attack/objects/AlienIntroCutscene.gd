extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play('alien_intro')

func play_bob_animation():
	animation_player.play('alien_bob')

func play_outro_cutscene():
	animation_player.play('alien_outro')

func outro_cutscene_finished():
	SignalBus.start_game.emit()

func deactivate_player():
	SignalBus.deactivate_player.emit()
	
	
func activate_player():
	SignalBus.activate_player.emit()
