extends Node
class_name DialogueManager

# Reference the input line edit
@export var player_input: LineEdit

# reference the dialog display area
@export var dialogue_display: VBoxContainer

func _ready():
	player_input.text_submitted.connect(_player_input)
	

func _player_input(input:String):
	var display_label = Label.new()
	display_label.text = "> " + input
	dialogue_display.add_child(display_label)
	player_input.clear()
