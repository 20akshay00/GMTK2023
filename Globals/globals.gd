extends Node

var ammo_init : int = 30
var ammo : int = ammo_init
var wave : int = 1
var slow_motion_limit : float = 1.5
@onready var smtimer = $SlowMoTimer
