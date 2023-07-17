extends CanvasLayer

@onready var laser_label = $LaserCounter/VBoxContainer/Label
@onready var timerbar = $TextureProgressBar
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.\
func _ready() -> void:
	update_laser_text()
	timerbar.max_value = Globals.slow_motion_limit
	timerbar.value = timerbar.max_value
	
func _process(_delta: float) -> void:
	if Globals.smtimer.time_left != 0 and not Globals.smtimer.paused:
		timerbar.value = Globals.smtimer.time_left
		
	print(timerbar.value)
	
func update_laser_text() -> void:
	laser_label.text = str("x ", Globals.ammo)

func _on_gun_ammo_changed() -> void:
	update_laser_text()
	
func _on_gun_reset_slowmo() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(timerbar, "value", Globals.slow_motion_limit, 0.2)
	
