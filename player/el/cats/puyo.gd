extends Sprite2D
class_name Puyo

@onready var BULLET = preload("res://player/el/bullet.tscn")
@onready var puyo_attack_timer = $"../Timers/PuyoAttackTimer"
@onready var projectiles = $"../Projectiles"
@onready var player : Player = $"../.."
var can_attack : bool = true

func _physics_process(_delta):
	attack()

func attack():
	if Input.is_action_pressed("primary attack") and can_attack:
		var bullet = BULLET.instantiate()
		projectiles.add_child(bullet)   
		bullet.global_position = player.puyo_marker.global_position
		puyo_attack_timer.start()
		can_attack = false

func _on_puyo_attack_timer_timeout():
	can_attack = true
