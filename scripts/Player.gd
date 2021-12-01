extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 100
var velocity = Vector2(0,0)
var hv = Vector2(0,0)
onready var tilemap =  get_parent().get_node("TileMap")
onready var player = get_parent().get_node("Player")
onready var blue_ghost = get_parent().get_node("BlueGhost")
onready var orange_ghost = get_parent().get_node("OrangeGhost")
onready var red_ghost = get_parent().get_node('RedGhost')
onready var pink_ghost = get_parent().get_node('PinkGhost')

func _ready():
	$AnimatedSprite.play("movement")
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hv = velocity/2
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(0,-speed)
		#$soundChomp.play()
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
	
	## warp 
	if player.position.x >445:
		player.position.x = 10
		player.position.y = 277
		
	if player.position.x<5:
		player.position.x = 441
		player.position.y = 277
	
	var collision = move_and_collide(velocity*delta)
	if collision:
		var collided_obj = collision.collider.name
		
		if("Ghost" in collided_obj and tilemap.power_active()==false):
			print("I collided with a ghost")
			get_tree().change_scene("res://assets/game assets/misc/LoseScreen.tscn")
			set_process(false)	
			
		elif("Ghost" in collided_obj and tilemap.power_active()==true):
			print("Eat ghost")
			
	
	var tile_eaten = tilemap.eat(player.position)		
	

		
	
	
#	pass
