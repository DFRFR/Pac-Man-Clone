extends CanvasLayer


func _ready():
	$YouWin.play()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://levels/Main Menu.tscn")
		queue_free()

func _on_RestartButton_pressed():
	get_tree().reload("res://levels/Sample Level 1.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://levels/Main Menu.tscn")
