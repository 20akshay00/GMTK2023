extends Node2D

var flying_enemy = 1
var crawling_enemy = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GameMusic = MusicPlayer.get_node("GameMusic")
	#GameMusic.play() 
	#var tween = get_tree().create_tween()
	#tween.tween_property(GameMusic, "volume_db", 0, 1)
	
	Globals.ammo = Globals.ammo_init
	$Gun.ammo_changed.emit()
	
	$CrawlingSpawner.spawn(flying_enemy)
	$FlyingSpawner.spawn(crawling_enemy)
	$Enemies.wave_count =  flying_enemy + crawling_enemy
	$Enemies.count = $Enemies.wave_count
	
func generate_wave():
	Globals.wave += 1
	flying_enemy += [1, 2][randi() % 2]
	crawling_enemy += 1
	$CrawlingSpawner.spawn(flying_enemy)
	$FlyingSpawner.spawn(crawling_enemy)
	$Enemies.wave_count =  flying_enemy + crawling_enemy
	$Enemies.count = $Enemies.wave_count
	
	var tween = get_tree().create_tween()
	tween.tween_property($UI/WaveLabel, "text",  str("Wave ", Globals.wave), 1)
	
	$UI/EnemyCounter/VBoxContainer/Label.text = str("x ", $Enemies.wave_count)
	
func _on_enemies_enemies_cleared() -> void:
	generate_wave()
