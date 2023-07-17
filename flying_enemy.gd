extends CharacterBody2D

@export var blink_high : float = 0.9
@export var health : int = 1
@export var ammo_boost : int = 10

@export var prob_flip : float = 0.005
@export var prob_shift : float = 0.01

@onready var sprite := $AnimatedSprite2D

@export var speed = 50

var dir = 1

func _ready() -> void:
	randomize()
	sprite.material.set_shader_parameter("mix_value", 0.)
		
func _process(_delta: float) -> void:			
	if dir == -1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func _physics_process(delta : float) -> void:
	var offset = Vector2(0., 0.)
	var rvar = randf()
	if rvar < prob_flip:
		dir *= -1
	elif rvar < prob_flip + prob_shift:
		offset += Vector2(0, -10) * [1, -1][randi() % 2]
		
	var collision = move_and_collide(speed * dir * delta * (Vector2(1, 0) + offset))
	
	if collision != null:
		dir *= -1
		
func hit() -> void:
	health -= 1
	var tween = get_tree().create_tween()
		
	if health == 0:
		tween.tween_property(sprite, "modulate:a", 0., 0.2)
		$CollisionShape2D.queue_free()
		$Target.visible = false
		$GPUParticles2D.emitting = true
		tween.tween_property($GPUParticles2D, "modulate:a", 0., 0.6)
		get_parent()._check_if_empty()
		tween.tween_callback(queue_free)
	else:
		for i in range(4):
			tween.tween_property(sprite, "material:shader_parameter/mix_value", blink_high, 0.1)
			tween.tween_property(sprite, "material:shader_parameter/mix_value", 0., 0.1)
		

