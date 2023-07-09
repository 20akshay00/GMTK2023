extends Control

func _ready() -> void:
	$Message.text = str("You made it till wave ", Globals.wave, "!")
	
func _on_button_pressed() -> void:
	TransitionLayer.change_scene("res://level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
