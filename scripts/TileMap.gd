extends TileMap

onready var player = get_parent().get_node("Player")

onready var blue_ghost = get_parent().get_node("BlueGhost")
onready var orange_ghost = get_parent().get_node("OrangeGhost")
onready var red_ghost = get_parent().get_node("RedGhost")
onready var pink_ghost = get_parent().get_node("PinkGhost")

onready var timer = get_parent().get_parent().get_node("Timer")
onready var is_powered_up = false

const tile_type = {
	power_nav_pellet = 14,
	nav_pellet = 13,
	nav_tile = 12,
	black = 11,
	black2 = 15,
	pellet = 5,
	power_pellet = 6}
	
func _ready():
	timer.set_wait_time(10)
	is_powered_up = false

func _on_Timer_timeout():
	blue_ghost.default_anim()
	orange_ghost.default_anim()
	pink_ghost.default_anim()
	red_ghost.default_anim()
	is_powered_up = false
	print('Timer done')
	 
func power_active():
	pass
	
func eat(pos):
	var current_tile = world_to_map(pos)
	var tile = get_cellv(current_tile)
	
	if(tile == tile_type.power_pellet):
		print("I ate a power pellet")
		set_cellv(current_tile, tile_type.black2)
		$chomp.play()
		get_parent().get_parent().get_node("UI/Score").add_score(50)
		
		timer.start()
		blue_ghost.power_up_anim()
		orange_ghost.power_up_anim()
		pink_ghost.power_up_anim()
		red_ghost.power_up_anim()
		is_powered_up = true
		
	if(tile == tile_type.pellet):
		set_cellv(current_tile, tile_type.black2)
		$chomp.play()
		get_parent().get_parent().get_node("UI/Score").add_score(10)

func _process(delta):
	var count = 0
	
	for i in range(get_used_rect().size.x):
		
		for j in range(get_used_rect().size.y+10):
			
			var tile = get_cell(i,j)
			if(tile == tile_type.pellet or tile==tile_type.nav_pellet
			or tile== tile_type.nav_pellet or tile==tile_type.power_nav_pellet):
				count += 1	
	#print("Pellets eaten:"+str(242-count))
	
	if(count == 0):
		#print("won")
		$win.play()
		get_tree().change_scene("res://assets/game assets/misc/WinScreen.tscn")
		set_process(false)
	#else:
		#print(count)



