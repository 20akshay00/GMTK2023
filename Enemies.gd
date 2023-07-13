extends Node2D

signal enemies_cleared

func _check_if_empty():
	if len(get_children()) == 1:
		enemies_cleared.emit()
