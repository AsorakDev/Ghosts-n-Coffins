extends State
class_name Jump

@onready var player : Player = $"../.."

func stateEnter():
	player.jump_timer.start()
	player.gravity = 30
	jump()
	
func stateUpdate(_delta):
	vary_jump_height()
	transitions()

func stateExit():
	player.can_jump = false
	player.coyote_timer.stop()

func jump():
	if player.can_jump or not player.coyote_timer.is_stopped():
		player.velocity.y = player.jump_speed

func transitions():
	if not player.is_on_floor() and player.velocity.y > 0:
		player.alter_move = false
		state_transition.emit(self, "Fall")

	if player.jump_timer.is_stopped():
		if player.is_on_floor():
			state_transition.emit(self, "Idle")
	
	if not player.is_on_floor() and player.velocity.y < 0 and \
	Input.is_action_just_pressed("primary attack") and player.can_arial_attack:
		state_transition.emit(self, "ArialAttack")

func vary_jump_height():
	pass
