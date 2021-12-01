extends TileMap



onready var player = get_parent().get_node("Player")

onready var blue_ghost = get_parent().get_node("BlueGhost")
onready var orange_ghost = get_parent().get_node("OrangeGhost")
onready var red_ghost = get_parent().get_node("RedGhost")
onready var pink_ghost = get_parent().get_node("PinkGhost")
var power_active = false
onready var timer = get_parent().get_parent().get_node("Timer")

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
	pass

func _on_Timer_timeout():
	if(blue_ghost != null):
		print(blue_ghost)
		blue_ghost.default_anim()

	elif(orange_ghost != null):
		orange_ghost.default_anim()
		
	elif(pink_ghost != null):
		pink_ghost.default_anim()
	
	elif(red_ghost != null):
		red_ghost.default_anim()

	power_active = false
	print('Timer done')
	 
func power_active():
	return power_active
	
func eat(pos):
	var current_tile = world_to_map(pos)
	var tile = get_cellv(current_tile)
	if(tile==tile_type.power_pellet):
		print("I ate a power pellet")
		timer.start()
		
		blue_ghost.power_up_anim()
		orange_ghost.power_up_anim()
		pink_ghost.power_up_anim()
		red_ghost.power_up_anim()
		power_active = true
		
	if(tile == tile_type.pellet or tile == tile_type.power_pellet):
		set_cellv(current_tile, tile_type.black)
		
		$chomp.play()
	return tile

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



