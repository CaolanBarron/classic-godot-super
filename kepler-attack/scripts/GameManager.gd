extends Node2D

@onready var win_screen = $"../UI/WinScreen"
@onready var loss_screen = $"../UI/LossScreen"
@export var has_cutscene:bool

func _ready():
	SignalBus.aliens_win.connect(_aliens_win)
	SignalBus.all_aliens_destroyed.connect(_players_win)
	if !win_screen:
		printerr('Missing win screen')
	if !loss_screen:
		printerr('Missing loss screen')
	(win_screen.find_child('Button') as Button).button_down.connect(_replay)
	(loss_screen.find_child('Button') as Button).button_down.connect(_replay)
	
	if !has_cutscene:
		SignalBus.start_game.emit()


func _aliens_win():
	loss_screen.visible = true


func _players_win():
	win_screen.visible = true


func _replay():
	SignalBus.reset_score.emit()
	SignalBus.reset_player.emit()
	win_screen.visible = false
	loss_screen.visible = false
	SignalBus.start_game.emit()

