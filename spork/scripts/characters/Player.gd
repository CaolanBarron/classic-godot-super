extends Character
class_name Player

@onready var dialogue_manager: DialogueManager = %DialogueManager

func _ready():
	if !dialogue_manager:
		printerr('Player: Dialogue manager reference is missing')
		return
	
	display_surroundings()

func find_usable_objects():
	var siblings:Array = get_parent().get_children()
	siblings += get_children()
	return siblings.filter(func(o): return o.name != 'Player')


func get_surrounding_descriptions() -> Array:
	# Get the parent location
	var parent_location = get_parent()
	# Get usable objects
	var usable_objects = find_usable_objects()
	usable_objects.push_front(parent_location)
	var description_strings = \
		usable_objects.map(func (o): return o.scene_description)
	return description_strings.filter(func(o): return o)


func display_surroundings():
	var descriptions = get_surrounding_descriptions()
	dialogue_manager.display_multiple_outputs(descriptions)
