extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var GameMusic = MusicPlayer.get_node("GameMusic")
	GameMusic.play() 
	var tween = get_tree().create_tween()
	tween.tween_property(GameMusic, "volume_db", 0, 1)
	
	Globals.ammo = Globals.ammo_init

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

