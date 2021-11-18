extends Area2D

onready var walls = get_parent().get_node("Navigation2D/TileMap")
var path = []
var direction = Vector2(0,0)
var SPEED = 25

func _ready():
	position = walls.get_enemy_pos()
	path = walls.get_path_to_player()
	
func _process(delta):
	#print(path)
	if(path.size() > 1):
		var pos_to_move = path[0]
		direction = (pos_to_move - position).normalized()
		var distance = position.distance_to(path[0])
		if(distance > 1):
			position += SPEED * delta * direction
		else:
			path.remove(0)
	else:
		path = walls.get_path_to_player()


func _on_OrangeGhost_area_entered(area):
	#print(area.name)
	if area.name == "Player":
		get_tree().change_scene("res://assets/game assets/misc/LoseScreen.tscn")
	pass
