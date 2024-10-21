extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State

var states :Dictionary

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		


func _process(delta):
	current_state.Process(delta)


func _physics_process(delta):
	current_state.Physics_process(delta)


func on_child_transitioned(state, new_state_name):
	if current_state != state:
		return
	
	if !states.has(new_state_name.to_lower()): 
		print('Cannot find state: ' + new_state_name)
		return 
	
	var new_state = states[new_state_name.to_lower()]
	if !new_state: 
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
	
	
