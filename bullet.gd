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
		$Line2D.points[1] = to_local(get_collision_point())		
		
		if get_collider().has_node("Target"):
			if (get_collider() != target):
				if target != null:
					target.get_node("Target").visible = false
					
				target = get_collider()
				target.get_node("Target").visible = true
		elif target != null:
			target.get_node("Target").visible = false
			target = null						
			
func shoot() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Line2D, "width", max_width, 0.05)
	tween.tween_property($Line2D, "width", min_width, 0.05)

