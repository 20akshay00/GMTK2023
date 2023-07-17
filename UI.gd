extends CanvasLayer

@onready var laser_label = $LaserCounter/VBoxContainer/Label
@onready var enemy_label = $EnemyCounter/VBoxContainer/Label

@onready var timerbar = $TextureProgressBar
@onready var timer = $Timer

var can_update = true

# Called when the node enters the scene tree for the first time.\
func _ready() -> void:
	update_laser_text()
	timerbar.max_value = Globals.slow_motion_limit
	timerbar.value = timerbar.max_value
	enemy_label.text = "x 2"
	
func _process(_delta: float) -> void:
	if not Globals.smtimer.is_paused() and can_update:
		timerbar.value = Globals.smtimer.time_left
		
func update_laser_text() -> void:
	laser_label.text = str("x ", Globals.ammo)

func _on_gun_ammo_changed() -> void:
	update_laser_text()
	
func _on_gun_reset_slowmo() -> void:
	can_update = false
	var tween = get_tree().create_tween()
	tween.tween_property(timerbar, "value", Globals.slow_motion_limit, 0.1)
	tween.finished.connect(_reset_update)
	
func _reset_update():
	can_update = true

func _on_enemies_enemy_killed(count) -> void:
	enemy_label.text = str("x ", count)
