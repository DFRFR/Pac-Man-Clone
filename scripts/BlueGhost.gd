extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 30
onready var tilemap = get_parent().get_node("TileMap")
var velocity = Vector2(0, 0)

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null
onready var line2d = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$BlueAnimSprite.play("default")
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]

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
	if path.size() > 0:
		velocity = position.direction_to(path[1]) * speed
		
		if global_position == path[0]:
			path.pop_front()
	
func create_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(position, player.position, false)
		#print(path)
		line2d.points = path
		
func move():
	velocity = move_and_slide(velocity)
	
func power_up_anim():
	$BlueAnimSprite.play('power-up')
func default_anim():
	$BlueAnimSprite.play('default')
