extends Node2D

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		label.text = "shoot"
	elif Input.is_action_pressed("rotate_cw"):
		label.text = "rotate cw"
	elif Input.is_action_pressed("rotate_ccw"):
		label.text = "rotate ccw"
	elif Input.is_action_just_pressed("hop"):
		label.text = "hop"
