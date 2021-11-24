extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 100
var velocity = Vector2(0,0)
onready var tilemap =  get_parent().get_node("TileMap")
onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("movement")
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0,-speed)
		rotation = deg2rad(-90)
		
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2(0,speed)
		rotation = deg2rad(90)
		
	elif Input.is_action_pressed("ui_left"):
		velocity = Vector2(-speed,0)
		rotation = deg2rad(180)
		
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2(speed,0)
		rotation = deg2rad(0)
	
	if player.position.x >445:
		player.position.x = 10
		player.position.y = 277
	if player.position.x<5:
		player.position.x = 441
		player.position.y = 277
	
	move_and_collide(velocity*delta)
	print(player.position)
	tilemap.eat(player.position)
	
	
#	pass
