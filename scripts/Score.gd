extends Label

onready var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Score:" + str(score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_score(points):
	score += points
	set_text("Score:" + str(score))
