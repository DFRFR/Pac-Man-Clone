extends Area2D

var direction = Vector2(0,0)
export var SPEED = 0.1
onready var walls = get_parent().get_node("TileMap")

func _ready():
	$AnimatedSprite.play("movement")
	

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(0, -1)
		rotation = deg2rad(-90)
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(0, 1)
		rotation = deg2rad(90)
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, 0)
		rotation = deg2rad(180)
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0)
		rotation = deg2rad(0)
		
	var pos_to_move = walls.is_tile_vacant(position, direction)
	if(direction != Vector2(0,0)):
		position = position.linear_interpolate(pos_to_move, SPEED + delta)
		$PacmanWakka.play()
		walls.eat(position)
		
	
	#position = walls.is_tile_vacant(position, direction)
