extends Sprite2D
class_name Peko

@onready var BULLET = preload("res://player/el/bullet.tscn")
@onready var peko_attack_timer = $"../../Timers/PekoAttackTimer"
@onready var projectiles = $"../../Projectiles"
@onready var player : Player = $"../.."
var can_attack : bool = true

func _physics_process(_delta):
	attack()

func attack():
	if Input.is_action_pressed("primary attack") and can_attack:
		var bullet = BULLET.instantiate()
		projectiles.add_child(bullet)
		bullet.global_position = player.peko_marker.global_position
		can_attack = false

func _on_peko_attack_timer_timeout():
	can_attack = true
