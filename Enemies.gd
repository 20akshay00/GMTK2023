extends Node2D

var count = 2
var wave_count = 2

signal enemies_cleared

func reduce_count():
	count -= 1
	
	if count == 0:
		enemies_cleared.emit()
