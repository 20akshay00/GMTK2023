extends CharacterBody2D

@export var blink_high : float = 0.9
@export var health : int = 2

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
	sprite.material.set_shader_parameter("mix_value", 0.)
		
func _process(_delta: float) -> void:
	if health <= 0 and not $GPUParticles2D.emitting and sprite.modulate.a == 0.:
		queue_free()
	
func hit() -> void:
	health -= 1
	var tween = get_tree().create_tween()
		
	if health == 0:
		tween.tween_property(sprite, "modulate:a", 0., 0.2)
		$CollisionShape2D.queue_free()
		$Target.visible = false
		$GPUParticles2D.emitting = true
		tween.tween_property($GPUParticles2D, "modulate:a", 0., 0.6)
	else:
		for i in range(4):
			tween.tween_property(sprite, "material:shader_parameter/mix_value", blink_high, 0.1)
			tween.tween_property(sprite, "material:shader_parameter/mix_value", 0., 0.1)
		

