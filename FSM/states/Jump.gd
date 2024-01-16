extends State
class_name Jump

@onready var player : Player = $"../.."

func stateEnter():
	player.jump_timer.start()
	player.gravity = 30
	jump()
	
func stateUpdate(_delta):
	transitions()

func stateExit():
	player.can_jump = false
	player.coyote_timer.stop()

func jump():
	if player.can_jump or not player.coyote_timer.is_stopped():
		player.velocity.y = player.jump_speed

func transitions():
	if not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
		
	if player.jump_timer.is_stopped():
		if player.direction.x == 0 and player.is_on_floor():
			state_transition.emit(self, "Idle")

		if player.direction.x != 0 and player.is_on_floor():
			state_transition.emit(self, "Walk")
