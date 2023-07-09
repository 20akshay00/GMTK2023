extends Control

func _ready() -> void:
	$MenuMusic.play()
	var tween = get_tree().create_tween()
	tween.tween_property($MenuMusic, "volume_db", 0, 0.2)
	
func _on_play_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($MenuMusic, "volume_db", -80, 0.2)	
	TransitionLayer.change_scene("res://level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	pass # Replace with function body.
