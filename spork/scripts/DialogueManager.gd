extends Node
class_name DialogueManager

# Reference the input line edit
@export var player_input: LineEdit

# reference the dialog display area
@export var dialogue_display: VBoxContainer

@onready var input_parser: InputParser = $"../InputParser"

func _ready():
	# Validate startup requirements
	if !input_parser:
		printerr('No valid input parser found')
	
	player_input.text_submitted.connect(_player_input)
	
	

func _player_input(input:String):
	# validate input
	var formatted_input = input.strip_edges()
	if formatted_input.length() == 0: return
	dialogue_display.add_child(_player_input_label(formatted_input))
	var parser_output = input_parser.parse_command(formatted_input)
	player_input.clear()
	if !parser_output:
		return
	if type_string(typeof(parser_output)) == 'Array':
		display_multiple_outputs(parser_output)
	else:
		dialogue_display.add_child(_parser_output_label(parser_output))


func _player_input_label(input: String) -> Label:
	var display_label = Label.new()
	display_label.add_theme_color_override('font_color', Color.AQUA)
	display_label.text = "> " + input
	display_label.custom_minimum_size = Vector2(100,0)
	display_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	return display_label


# TODO: rename this function
func _parser_output_label(output: String) -> Label:
	var display_label = Label.new()
	display_label.text = output
	display_label.custom_minimum_size = Vector2(100,0)
	display_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	return display_label


func display_multiple_outputs(outputs: Array):
	for output in outputs:
		dialogue_display.add_child(_parser_output_label(output))
