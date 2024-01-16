extends State
class_name Walk

@onready var player : Player = $"../.."

func stateEnter():
	pass
		
func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func transitions():
	if player.direction.x == 0 and player.is_on_floor():
		state_transition.emit(self, "Idle")
	
	if player.direction.x != 0 and Input.is_action_just_pressed("up"):
		state_transition.emit(self, "Jump")
	
	if player.direction.x != 0 and Input.is_action_pressed("down"):
		state_transition.emit(self, "Crouch")
	
	if player.direction.x != 0 and not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
		player.coyote_timer.start()
		
	if Input.is_action_just_pressed("shoot"):
		state_transition.emit(self, player.current_weapon)
