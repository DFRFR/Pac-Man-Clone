extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 30
onready var tilemap = get_parent().get_node("TileMap")
var velocity = Vector2(0, 0)
onready var pink_spawn = get_parent().get_node("PinkSpawn")
var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
onready var line2d = $Line2D

var is_home = false
onready var pink_timer = pink_spawn.get_node("PinkTimer")

onready var pink_ghost = get_parent().get_node('PinkGhost')


# Called when the node enters the scene tree for the first time.
func _ready():
	$PinkAnimSprite.play("default")
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

	pink_timer.set_wait_time(15)
	pink_timer.start()
	is_home = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line2d.global_position = Vector2.ZERO
	if player and levelNavigation:
		create_path()
		navigate()
	move()
	
	var collide = move_and_collide(velocity*delta)
	#var tile = tilemap.get_cellv(tilemap.world_to_map())
	#print(tile)
	if collide:
		pass
		#print("Enemy collided with:"+str(collide.collider_id))

func navigate():
	if path.size() > 0 and !is_home:
		velocity = position.direction_to(path[1]) * speed
		
		if global_position == path[0]:
			path.pop_front()
	else:
		path = levelNavigation.get_simple_path(position, pink_spawn.position, false)
		velocity = position.direction_to(path[1]) * (speed * 5)
		if global_position == path[0]:
			path.pop_front()
		if position == pink_spawn.position:
			velocity = Vector2(0, 0)
	
func create_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(position, player.position, false)
		#print(path)
		line2d.points = path
		
func move():
	velocity = move_and_slide(velocity)
	if pink_ghost.position.x >445:
		pink_ghost.position.x = 10
		pink_ghost.position.y = 277
		
	if pink_ghost.position.x<5:
		pink_ghost.position.x = 441
		pink_ghost.position.y = 277
		
func power_up_anim():
	$PinkAnimSprite.play('power-up')
func default_anim():
	$PinkAnimSprite.play('default')
	
func go_home(body):
	#body.position = pink_spawn.position
	pink_ghost.set_collision_layer_bit(0, 0)
	$PinkAnimSprite.play('death')
	is_home = true
	pink_timer.start()
	#body.velocity = Vector2(0, 0)

func _on_PinkTimer_timeout():
	default_anim()
	pink_ghost.set_collision_layer_bit(0, 1)
	is_home = false
	pink_timer.set_wait_time(10)
