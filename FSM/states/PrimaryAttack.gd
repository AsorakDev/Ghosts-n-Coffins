extends State
class_name PrimaryAttack

@onready var BULLET = preload("res://player/el/bullet.tscn")
@onready var projectiles = $"../../Projectiles"
@onready var player : Player = $"../.."

func stateEnter():
	pass

func stateUpdate(_delta):
	attack()
	transitions()

func stateExit():
	pass
	
func transitions():
	if Input.is_action_just_released("primary attack"):
		if player.is_on_floor() and player.direction.x == 0:
			state_transition.emit(self, "Idle")
		
		if player.is_on_floor() and player.direction.x != 0:
			state_transition.emit(self, "Walk")
	
	if Input.is_action_just_pressed("down"):
		state_transition.emit(self, "Crouch")
	
	if Input.is_action_just_pressed("up") and player.can_jump:
		state_transition.emit(self, "Jump")
	
	if not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
		player.coyote_timer.start()

func attack():
	if Input.is_action_pressed("primary attack") and player.can_attack:
		var bullet = BULLET.instantiate()
		projectiles.add_child(bullet)
		bullet.global_position = player.el_marker.global_position
		player.primary_attack_timer.start()
		player.can_attack = false

func _on_primary_attack_timer_timeout():
	player.can_attack = true
