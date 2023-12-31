extends RigidBody2D

signal ammo_changed
signal reset_slowmo

@export var recoil_strength : float = 1000.
@export var rotation_strength_low : float = 100.
@export var rotation_strength_high : float = 300.
@export var hop_strength : float = 300.
@export var max_angular_velocity : float = 10.
@export var max_num_hops : int = 3

@export var audio_speed_high : float = 1.
@export var audio_speed_low : float = 0.8

@onready var bullet = $Bullet

var can_shoot = true
var can_slowmo = true
var num_hops = 1
var is_touching = false
var rotation_strength = rotation_strength_high
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.zoom = Vector2(0.75, 0.75)
	Globals.smtimer.set_paused(true)
	Globals.smtimer.start(Globals.slow_motion_limit)
	Globals.smtimer.timeout.connect(_on_slow_motion_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot and Globals.ammo > 0:
		apply_central_impulse(Vector2(cos(rotation), sin(rotation)) * recoil_strength)
		bullet.shoot()
		Globals.ammo -= 1
		ammo_changed.emit()
		can_shoot = false
		$ShootTimer.start()
		#$ShootSFX.play()
		
		if bullet.is_colliding() and bullet.get_collider().has_method("hit"):
			var enemy = bullet.get_collider()
			
			if enemy.health == 1:
				Globals.ammo += enemy.ammo_boost
				ammo_changed.emit()
									
			enemy.hit()
						
		if Globals.ammo == 0:
			var tween = get_tree().create_tween()
			tween.tween_property($Camera2D, "zoom", Vector2(4., 4.), 4)
			tween.finished.connect(game_over)
			
	elif Input.is_action_pressed("rotate_cw"):
		if abs(angular_velocity) < max_angular_velocity:
			apply_torque_impulse(rotation_strength)
	elif Input.is_action_pressed("rotate_ccw"):
		if abs(angular_velocity) < max_angular_velocity:
			apply_torque_impulse(-rotation_strength)
	elif Input.is_action_just_pressed("hop") and num_hops > 0:
		apply_central_impulse(Vector2.UP * hop_strength)
		num_hops -= 1

	if (Input.is_action_just_pressed("rotate_ccw") or Input.is_action_just_pressed("rotate_cw")) and can_slowmo and not is_touching: 
		start_slowmo()
	elif (Input.is_action_just_released("rotate_ccw") or Input.is_action_just_released("rotate_cw")) and Engine.time_scale == 0.2:
		end_slowmo()
		
	if is_touching and Engine.time_scale == 1.0:
		reset_slowmo.emit()
		can_slowmo = true
		Globals.smtimer.start(Globals.slow_motion_limit)
	
func start_slowmo() -> void:
	Globals.smtimer.set_paused(false)
	Engine.time_scale = 0.2	
	rotation_strength = rotation_strength_low
	$Camera2D/SlowMoCanvas.slowmo_effect(0.15, 0.5)
	AudioServer.playback_speed_scale = audio_speed_low
	
func end_slowmo() -> void:
	Globals.smtimer.set_paused(true)
	Engine.time_scale = 1.0
	rotation_strength = rotation_strength_high
	$Camera2D/SlowMoCanvas.slowmo_effect(0.3, 1.)
	AudioServer.playback_speed_scale = audio_speed_high
			
func _on_body_entered(body: Node) -> void:
	if not body.has_node("Target"):
		is_touching = true
		num_hops = max_num_hops
		
	
func _on_body_exited(_body: Node) -> void:
	is_touching = false

func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func _on_slow_motion_timeout() -> void:
	can_slowmo = false
	end_slowmo()

func game_over() -> void:
	TransitionLayer.change_scene("res://game_over.tscn")
