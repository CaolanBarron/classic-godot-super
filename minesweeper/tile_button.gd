extends TextureButton
class_name TileButton

@onready var label: Label = $Label
@onready var label2: Label = $Label2
@onready var bomb_timer: Timer = $Explosion
@onready var explosion_timer: Timer = $Ending

var mine:bool = false
var surrounding:int = 0
var coord: Vector2

var revealed: bool = false
var flagged: bool = false

var unrevealed_texture = preload("res://sprites/base-tile.png")
var revealed_texture = preload("res://sprites/revealed-tile.png")
var flag_texture = preload("res://sprites/flagged_sprite.png")
var bomb_texture = preload("res://sprites/dabomb_sprite.png")
var explosion_texture = preload("res://sprites/daexplosion_sprite.png")

var game:Game

func _ready():
	gui_input.connect(_tile_selected)
	bomb_timer.timeout.connect(bomb_exploded)
	explosion_timer.timeout.connect(end_game)

func set_text(text):
	label.text = text


func set_coords():
	label2.text = '('+ str(coord.x)+','+str(coord.y)+')'

func _tile_selected(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				reveal(true)
			MOUSE_BUTTON_RIGHT:
				flag()


func reveal(initial: bool):
	if flagged: return
	if initial:
		if mine:
			print('GAME OVER')
			texture_normal = bomb_texture
			bomb_timer.start(1)
			revealed = true
			return
		if  surrounding > 0:
			set_text(str(surrounding))
			revealed = true
			return
	
	if mine: return
	if surrounding > 0:
		set_text(str(surrounding))
		revealed = true
		return
	if revealed: return
	
	texture_normal = revealed_texture
	revealed = true
	var x = coord.x
	var y = coord.y
	for x2 in range(x-1, x+2):
		for y2 in range(y-1,y+2):
			if x2 < 0 or x2 >= game.row_size:
				continue
			if y2 < 0 or y2 >= game.column_size:
				continue
			game.grid[x2][y2].reveal(false)


func flag():
	if revealed: return
	
	if flagged:
		flagged = false
		texture_normal = unrevealed_texture
		game.remove_flag()
	else:
		if game.flags_used < game.number_mines:
			flagged = true
			texture_normal = flag_texture
			game.add_flag()

func bomb_exploded():
	texture_normal = explosion_texture
	explosion_timer.start(1)

func end_game():
	get_tree().change_scene_to_file("res://game_over.tscn")
