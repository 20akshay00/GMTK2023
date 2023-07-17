extends Node2D

var count = 2
var wave_count = 2

signal enemies_cleared
signal enemy_killed(count : int)

func reduce_count():
	count -= 1
	enemy_killed.emit(count)
	
	if count == 0:
		enemies_cleared.emit()
