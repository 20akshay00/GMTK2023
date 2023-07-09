extends RayCast2D

@export var max_width = 10. 
@export var min_width = 0.

var target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Line2D.width = min_width
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if is_colliding():
		$Line2D.points[1] =  to_local(get_collision_point())		
		target = get_collider()
		if target.has_node("Target"):
			target.get_node("Target").visible = true
	else:
		$Line2D.points[1] = target_position
		if target != null and target.has_node("Target"):
			target.get_node("Target").visible = false
			
func shoot() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D, "width", max_width, 0.05)
	tween.tween_property($Line2D, "width", min_width, 0.05)

