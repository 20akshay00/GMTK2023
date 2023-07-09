extends Node2D

var flying_enemy = 1
var crawling_enemy = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GameMusic = MusicPlayer.get_node("GameMusic")
	GameMusic.play() 
	var tween = get_tree().create_tween()
	tween.tween_property(GameMusic, "volume_db", 0, 1)
	
	Globals.ammo = Globals.ammo_init
	
	$CrawlingSpawner.spawn(flying_enemy)
	$FlyingSpawner.spawn(crawling_enemy)
	
func generate_wave():
	Globals.wave += 1
	flying_enemy += [1, 2][randi() % 2]
	crawling_enemy += 1
	$CrawlingSpawner.spawn(flying_enemy)
	$FlyingSpawner.spawn(crawling_enemy)
	
	var tween = get_tree().create_tween()
	tween.tween_property($UI/WaveLabel, "text",  str("Wave ", Globals.wave), 2)
	
func _process(_delta : float):
	if $Enemies.get_children().size() == 0:
		generate_wave()
		

