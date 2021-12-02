extends Label

onready var pellets = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Pellets:" + str(pellets))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_pellets(points):
	pellets += points
	set_text("Pellets:" + str(pellets))
