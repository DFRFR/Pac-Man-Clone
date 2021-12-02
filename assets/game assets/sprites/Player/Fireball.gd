extends KinematicBody2D

const fireball_speed = 100
var velocity = Vector2()

func _ready():
	set_process(true)
	get_node("AnimatedSprite").play()
	
func _process(delta):
	position = position + velocity * delta
	var collision = move_and_collide(velocity*delta)
	if collision:
		var collided_obj_name = collision.collider.name
		var collided_obj = collision.collider

		if("Ghost" in collided_obj_name):
			print("I collided with a ghost")
			collided_obj.go_home(collided_obj)
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
