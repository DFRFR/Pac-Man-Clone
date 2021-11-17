extends Area2D

var rng = RandomNumberGenerator.new()
var direction = Vector2(0,0)
var path = []
export var SPEED = 0.1
onready var walls = get_parent().get_node("TileMap")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	rng.randomize()
	var r = rng.randi_range(1, 4)
	translate(Vector2(rng,rng)*delta)
	if r == 1:
		direction = Vector2(0, -1)
		rotation = deg2rad(-90)
	elif r == 2:
		direction = Vector2(0, 1)
		rotation = deg2rad(90)
	elif r == 3:
		direction = Vector2(-1, 0)
		rotation = deg2rad(180)
	elif r == 4:
		direction = Vector2(1, 0)
		rotation = deg2rad(0)
	var pos_to_move = walls.is_tile_vacant(position, direction)
	position = position.linear_interpolate(pos_to_move, SPEED + delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
