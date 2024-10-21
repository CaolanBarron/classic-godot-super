extends Node
class_name DialogManager

const DIALOGUE_SCENE = preload("res://hardcore/objects/Dialog.tscn")


signal message_requested()

signal finished()


var _messages := []
var _active_dialogue_offset := 0
var _is_active := false
var cur_dialogue_instance: Dialog



func show_messages(message_list: Array) -> void:
	# Only allow triggering if its not currently showing something
	if _is_active:
		return
	_is_active  = true
	
	SignalBus.start_dialogue.emit()
	
	_messages = message_list
	_active_dialogue_offset = 0
	var _dialogue = DIALOGUE_SCENE.instantiate()
	$"..".add_child(_dialogue)
	
	cur_dialogue_instance = _dialogue
	
	_show_current()

func _show_current() -> void:
	emit_signal("message_requested")
	var _msg := _messages[_active_dialogue_offset] as String
	cur_dialogue_instance.display_message(_msg)


func _input(event: InputEvent) -> void:
	if(event.is_action("next_dialogue") and _is_active and cur_dialogue_instance.message_is_fully_visible()):
		if _active_dialogue_offset < _messages.size() - 1:
			_active_dialogue_offset += 1
			_show_current()
		else:
			_hide()

func _hide():
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	_is_active = false
	SignalBus.end_dialogue.emit()
