extends CanvasLayer

@onready var slowmofilter = $SlowMoFilter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slowmofilter.material.set_shader_parameter("fade", 1.)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slowmo_effect(duration : float, val : float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(slowmofilter, "material:shader_parameter/fade", val, duration)
