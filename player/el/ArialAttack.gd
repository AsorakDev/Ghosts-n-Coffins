extends State
class_name ArialAttack

@onready var ARIAL_BULLET = preload("res://player/el/arial_bullet.tscn")
@onready var projectiles = $"../../Projectiles"
@onready var player : Player = $"../.."
@onready var old_speed : float = player.move_speed
var arial_speed : float = 500
var can_spawn : bool = true
var can_exit : bool = false

func stateEnter():
	player.alter_move = false
	player.can_arial_attack = false
	player.arial_attack_timer.start()
	player.move_speed = arial_speed
	player.velocity.y = 0
	player.gravity = 0
	
func stateUpdate(_delta):
	arial_attack()
	transitions()

func stateExit():
	can_exit = false

func arial_attack():
	if can_spawn:
		player.arial_attack_spawn_timer.start()
		can_spawn = false
		player.velocity.y -= 10
		var left_bullet = ARIAL_BULLET.instantiate()
		var right_bullet = ARIAL_BULLET.instantiate()
		projectiles.add_child(left_bullet)
		projectiles.add_child(right_bullet)
		left_bullet.global_position = player.arial_marker_left.global_position
		right_bullet.global_position = player.arial_marker_right.global_position

func _on_arial_attack_timer_timeout():
	player.move_speed = old_speed
	can_exit = true

func transitions():
	if can_exit:
		if not player.is_on_floor():
				state_transition.emit(self, "Fall")
		
		if player.is_on_floor():
			state_transition.emit(self, "Idle")

func _on_arial_attack_spawn_timer_timeout():
	can_spawn = true
