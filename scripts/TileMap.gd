extends TileMap

onready var half_cell_size = get_cell_size()/2
const tile_type = {
	power_nav_pellet =14,
	nav_pellet =13,
	nav_tile = 12,
	black=11
	,pellet = 5
	,power_pellet = 6}
	
func _ready():
	pass


func is_tile_vacant(pos, direction):
	var current_tile = world_to_map((pos))
	var next_tile = get_cellv(current_tile + direction)


	var next_tile_pos = Vector2()

	if(next_tile == tile_type.black 
	or next_tile == tile_type.nav_tile
	or next_tile == tile_type.pellet 
	or next_tile == tile_type.power_pellet
	or next_tile == tile_type.power_nav_pellet
	or next_tile == tile_type.nav_pellet 
	or next_tile == tile_type.black):
		next_tile_pos = map_to_world(current_tile + direction) + half_cell_size
	elif(next_tile == 8):
		next_tile_pos = map_to_world(Vector2(220, 17))
	elif(next_tile == 9):
		next_tile_pos = map_to_world(Vector2(-190, 17))
	else:
		next_tile_pos = relocate(pos)
	return next_tile_pos

func relocate(pos):
	var tile = world_to_map(pos)
	return map_to_world(tile) + half_cell_size

func eat(pos):
	var current_tile = world_to_map(pos)
	var tile = get_cellv(current_tile)
	if(tile == tile_type.pellet or tile == tile_type.power_pellet
	or tile==tile_type.nav_pellet or tile == tile_type.power_nav_pellet):
		set_cellv(current_tile, tile_type.black)
		

func _process(delta):
	var count = 0
	for i in range(get_used_rect().size.x):
		for j in range(get_used_rect().size.y+10):
			var tile = get_cell(i,j)
			if(tile == 5):
				count += 1
				
	if(count == 0):
		print("won")
		get_tree().change_scene("res://assets/game assets/misc/WinScreen.tscn")
		set_process(false)
	#else:
		#print(count)
