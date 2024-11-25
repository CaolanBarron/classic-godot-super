extends RichTextLabel


var dialogues = ['[tornado]Vorp vorp vorp![/tornado]', 'HUMAN BOZOS', 'Kepler 22B solos lmao']
@onready var timer:Timer = $Timer

signal dialog_finished

var dialogue_offset:= 0

func _ready():
	timer.timeout.connect(reveal_letter)

func start_dialogue():
	display_message(dialogues[dialogue_offset])

func display_message(message:String) -> void:
	text = "[center]%s[/center]" % message
	visible_characters = 0
	timer.start()

func reveal_letter() -> void:
	if text.length() > visible_characters:
		visible_characters +=1
	else:
		timer.stop()

func message_is_fully_visible():
	return text.length() == visible_characters

func _input(event):		
	if dialogue_offset >= dialogues.size(): return
	if event.is_action_pressed('shoot') or event.is_action_pressed('interact'):
		if !message_is_fully_visible(): return
		
		dialogue_offset +=1
		if dialogue_offset >= dialogues.size():
			dialog_finished.emit()
			text = ''
			return
		display_message(dialogues[dialogue_offset])
