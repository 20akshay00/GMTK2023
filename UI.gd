extends CanvasLayer

@onready var laser_label = $LaserCounter/VBoxContainer/Label
# Called when the node enters the scene tree for the first time.
func update_laser_text() -> void:
	laser_label.text = str("x ", Globals.ammo)

func _on_gun_ammo_changed() -> void:
	update_laser_text()
