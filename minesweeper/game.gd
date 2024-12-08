extends Node2D
class_name Game

@export var row_size: int
@export var column_size: int
@export var number_mines: int

@export var button_container: GridContainer
@export var flags_label: Label

var tile_button = preload("res://button.tscn")

var flags_used: int = 0

var grid = []

func _ready():
	_create_grid()
	_display_grid()
	flags_label.text = str(number_mines - flags_used)

func _create_grid():
	for x in row_size:
		grid.append([])
		for y in column_size:
			var instance = tile_button.instantiate()
			instance.game = self
			instance.coord = Vector2(x,y)
			grid[x].append(instance)
	
	var mine_coords: Array = [] 
	for _mine in number_mines:
		var unique = false
		var random_coord = []
		while !unique:
			random_coord = [randi_range(0, row_size-1), randi_range(0, column_size-1)]
			unique = true
			for m in mine_coords:
				if m.hash() == random_coord.hash():
					unique = false
		mine_coords.append(random_coord)
	
	for coord in mine_coords:
		var x = coord[0]
		var y = coord[1]
		grid[x][y].mine = true
		for x2 in range(x-1, x+2):
			for y2 in range(y-1,y+2):
				if x2 < 0 or x2 >= row_size:
					continue
				if y2 < 0 or y2 >= column_size:
					continue
				grid[x2][y2].surrounding += 1


func _display_grid():
	for x in row_size:
		for y in column_size:
			button_container.add_child(grid[x][y])

func add_flag():
	flags_used +=1
	flags_label.text = str(number_mines - flags_used)

func remove_flag():
	flags_used -= 1
	flags_label.text = str(number_mines - flags_used)

func _process(delta):
	var game_won: bool = true
	for x in row_size:
		for y in column_size:
			if grid[x][y].mine:
				if !grid[x][y].flagged:
					game_won = false
			else:
				if !grid[x][y].revealed:
					game_won = false
	
	if game_won:
		get_tree().change_scene_to_file("res://win_scene.tscn")
