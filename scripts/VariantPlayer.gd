extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 100
export var max_speed = 100
var velocity = Vector2(0,0)
var hv = Vector2(0,0)
onready var tilemap =  get_parent().get_node("TileMap")
onready var player = get_parent().get_node("Player")
onready var blue_ghost = get_parent().get_node("BlueGhost")
onready var orange_ghost = get_parent().get_node("OrangeGhost")
onready var red_ghost = get_parent().get_node('RedGhost')
onready var pink_ghost = get_parent().get_node('PinkGhost')
onready var pellets = get_parent().get_parent().get_node("UI/Pellets")
onready var direction = ""
const fireball_scene = preload("res://assets/game assets/sprites/Player/Fireball.tscn")
onready var music_norm = tilemap.get_node('music') 
func _ready():
	$AnimatedSprite.play("movement")
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if pellets.pellets >= 10:
			shoot()
		
	if Input.is_action_just_pressed("ui_up"):
		direction = "up"
	elif Input.is_action_just_pressed("ui_down"):
		direction = "down"
	elif Input.is_action_just_pressed("ui_left"):
		direction = "left"
	elif Input.is_action_just_pressed("ui_right"):
		direction = "right"
		
	hv = velocity/2
	if direction == "up":
		velocity = Vector2(0,-speed)
		#$soundChomp.play()
		rotation = deg2rad(-90)
	elif direction == "down":
		velocity = Vector2(0,speed)
		rotation = deg2rad(90)
	elif direction == "left":
		velocity = Vector2(-speed,0)
		rotation = deg2rad(180)
	elif direction == "right":
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
		var collided_obj_name = collision.collider.name
		var collided_obj = collision.collider
		

		if("Ghost" in collided_obj_name):
			print("I collided with a ghost")
			if(tilemap.is_powered_up):
				collided_obj.go_home(collided_obj)
			else:
				if music_norm.playing == true:
					music_norm.stop()
				$DeathNoise.play()
				print("reload")
				get_tree().change_scene("res://assets/game assets/misc/LoseScreen.tscn")
				set_process(false)
	
		#if("Ghost" in collided_obj and tilemap.power_active()==false):
		#	print("I collided with a ghost")
		#	get_tree().change_scene("res://assets/game assets/misc/LoseScreen.tscn")
		#	set_process(false)	
			
		#elif("Ghost" in collided_obj and tilemap.power_active()==true):
		#	print("Eat ghost")
	var tile_eaten = tilemap.eat(player.position)	

func shoot():
	var fireball = fireball_scene.instance()
	get_parent().add_child(fireball)
	fireball.position = position
	fireball.rotation_degrees = rotation_degrees
	
	if direction == "up":
		fireball.velocity = Vector2(0, -fireball.fireball_speed)
	elif direction == "down":
		fireball.velocity = Vector2(0, fireball.fireball_speed)
	elif direction == "left":
		fireball.velocity = Vector2(-fireball.fireball_speed, 0)
	elif direction == "right":
		fireball.velocity = Vector2(fireball.fireball_speed, 0)
	
	pellets.add_pellets(-10)
	speed = max_speed - pellets.pellets
		
	
