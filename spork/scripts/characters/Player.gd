extends Character
class_name Player

@onready var dialogue_manager: DialogueManager = %DialogueManager

func _ready():
	if !dialogue_manager:
		printerr('Player: Dialogue manager reference is missing')
		return
	
	display_surroundings()
	SignalManager.describe_environment.connect(display_surroundings)

func find_usable_objects():
	var siblings:Array = get_parent().get_children()
	siblings += get_children()
	for object in siblings:
		if object is Item and object.can_open and object.is_open:
			siblings += object.get_children()
	return siblings.filter(func(o): return o.name != 'Player' and !(o is Location))


func get_surrounding_descriptions() -> Array:
	# Get the parent location
	var parent_location = get_parent()

	var surroundings = [parent_location]
	surroundings += parent_location.directions
	surroundings += find_usable_objects()
	
	surroundings = \
		surroundings.filter(func(o): 
			if o is Item: 
				return o.get_parent().name != 'Player'
			return true)
	
	surroundings = surroundings.filter(func(o): return o.scene_description)
	var scene_description_strings = \
		surroundings.map(func (o): return o.scene_description)
	return scene_description_strings


func display_surroundings():
	var descriptions = get_surrounding_descriptions()
	dialogue_manager.display_multiple_outputs(descriptions)

func display_inventory():
	var children = get_children()
	
	if children.size() == 0:
		return 'You do not have anything in your inventory right now'
		
	return children.map(func(o): return o.display_name)
