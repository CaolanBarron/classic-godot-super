extends Control
class_name Dialog

@onready var content:= get_node("ContentContainer/MarginContainer/Content")  as RichTextLabel
@onready var type_timer:= $TypeTimer as Timer

func display_message(message: String) -> void:
	content.text = "[center]%s[/center]" % message
	content.visible_characters = 0
	type_timer.start()
	
func reveal_letter() -> void:
	if content.text.length() > content.visible_characters:
		content.visible_characters +=1
	else:
		type_timer.stop()

func message_is_fully_visible():
	return content.text.length() == content.visible_characters
