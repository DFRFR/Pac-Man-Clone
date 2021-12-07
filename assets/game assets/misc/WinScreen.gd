extends CanvasLayer


func _ready():
	pass


func _on_RestartButton_pressed():
	get_tree().reload("res://levels/Sample Level 1.tscn")


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://levels/Main Menu.tscn")
