extends Area2D

var rng = RandomNumberGenerator.new()
var direction = Vector2(0,0)
var path = []
export var SPEED = 0.1
onready var walls = get_parent().get_node("Navigation2D/TileMap")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
