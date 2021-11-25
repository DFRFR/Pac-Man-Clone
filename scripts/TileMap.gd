extends TileMap

onready var half_cell_size = get_cell_size()/2
onready var player = get_parent().get_node("Player")


const tile_type = {
	power_nav_pellet = 14,
	nav_pellet =13,
	nav_tile = 12,
	black=11
	,pellet = 5
	,power_pellet = 6}
	
func _ready():
	pass

func eat(pos):
	var current_tile = world_to_map(pos)
	var tile = get_cellv(current_tile)
	if(tile == tile_type.pellet or tile == tile_type.power_pellet):
		set_cellv(current_tile, tile_type.black)


func _process(delta):
	var count = 0
	
	for i in range(get_used_rect().size.x):
		
		for j in range(get_used_rect().size.y+10):
			
			var tile = get_cell(i,j)
			if(tile == tile_type.pellet or tile==tile_type.nav_pellet):
				count += 1	
	print("Pellets eaten:"+str(count))
	
	if(count == 0):
		print("won")
		get_tree().change_scene("res://assets/game assets/misc/WinScreen.tscn")
		set_process(false)
	#else:
		#print(count)
