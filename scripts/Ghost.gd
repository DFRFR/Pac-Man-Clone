extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 10
onready var tilemap = get_parent().get_node("TileMap")
var velocity = Vector2(0,speed)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	# check if collide
		#check if  collision navi_tile
		# make descion turn 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var collide = move_and_collide(velocity*delta)
	#var tile = tilemap.get_cellv(tilemap.world_to_map())
	#print(tile)
	if collide:
		pass
		#print("Enemy collided with:"+str(collide.collider_id))

