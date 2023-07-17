extends CanvasLayer

@onready var laser_label = $LaserCounter/VBoxContainer/Label
@onready var timerbar = $TextureProgressBar
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.\
func _ready() -> void:
	update_laser_text()
	timerbar.value = 1

func _process(_delta: float) -> void:
	if timer.time_left != 0:
		timerbar.value = timer.time_left
	
func update_laser_text() -> void:
	laser_label.text = str("x ", Globals.ammo)

func _on_gun_ammo_changed() -> void:
	update_laser_text()

func _on_gun_slowmo_started() -> void:
	timer.start(1)

func _on_gun_slowmo_ended() -> void:
	timer.stop()
	var tween = get_tree().create_tween()
	tween.tween_property(timerbar, "value", 1, 0.2)
	

