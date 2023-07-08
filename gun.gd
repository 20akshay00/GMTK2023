extends RigidBody2D

@export var recoil_strength : float = 1000.
@export var rotation_strength_low : float = 100.
@export var rotation_strength_high : float = 300.
@export var hop_strength : float = 300.
@export var max_angular_velocity : float = 15.

@onready var bullet = $Bullet
@onready var smtimer = $SlowMoTimer
@onready var cooldowntimer = $SlowMoCooldown

var can_slowmo = false
var can_shoot = true
var is_touching = false
var rotation_strength = rotation_strength_high
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		apply_central_impulse(Vector2(cos(rotation), sin(rotation)) * recoil_strength)
		bullet.shoot()
		can_shoot = false
		$ShootTimer.start()
		if bullet.is_colliding():
			bullet.get_collider().hit()
	elif Input.is_action_pressed("rotate_cw"):
		if abs(angular_velocity) < max_angular_velocity:
			apply_torque_impulse(rotation_strength)
	elif Input.is_action_pressed("rotate_ccw"):
		if abs(angular_velocity) < max_angular_velocity:
			apply_torque_impulse(-rotation_strength)
	elif Input.is_action_just_pressed("hop"):
		apply_central_impulse(Vector2.UP * hop_strength)

	if (Input.is_action_just_pressed("rotate_ccw") or Input.is_action_just_pressed("rotate_cw")) and not is_touching: 
		Engine.time_scale = 0.2
		rotation_strength = rotation_strength_low
		$Camera2D/UI.slowmo_effect(0.15, 0.5)
		smtimer.start()
	elif Input.is_action_just_released("rotate_ccw") or Input.is_action_just_released("rotate_cw"):
		Engine.time_scale = 1.0
		rotation_strength = rotation_strength_high
		$Camera2D/UI.slowmo_effect(0.3, 1.)
		
func _on_slow_mo_timer_timeout() -> void:
	Engine.time_scale = 1.0
	can_slowmo = false

func _on_body_entered(body: Node) -> void:
	is_touching = true
	
func _on_body_exited(body: Node) -> void:
	is_touching = false

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
