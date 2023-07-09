extends Node2D

@onready var enemy_scene = preload("res://crawling_enemy.tscn")

func spawn(num_spawns : int) -> void:
	var spawners = get_children().slice(0, 5)

	for i in range(num_spawns):
		var pos : Vector2 = spawners[randi() % spawners.size()].position
		var enemy = enemy_scene.instantiate()
		enemy.position = pos
		add_child(enemy)
		
		$Timer.start()
		await $Timer.timeout
		
		
	
		
	
	
