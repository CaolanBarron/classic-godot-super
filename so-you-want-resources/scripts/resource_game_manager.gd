extends Node2D

@export var score_display: Label
@export var life_container: HBoxContainer
@export var resource_display:Label
@export var resource_manager:ResourceManager

var score = 0


func _ready():
	SignalBus.increase_score.connect(_increase_score)
	SignalBus.remove_chance.connect(_remove_chance)
	SignalBus.game_over.connect(_game_over)

func _increase_score(value):
	score += value
	score_display.text = str(score)

func _reset_score():
	score = 0

func _remove_chance():
	var texture_rects = life_container.get_children()
	
	for t:TextureRect in texture_rects:
		if t.visible:
			t.visible = false
			return

func _process(delta):
	var amount = resource_manager.resource_amount()
	resource_display.text = 'Resources: ' + str(amount)


func _game_over():
	get_tree().change_scene_to_file("res://levels/game_over.tscn")
