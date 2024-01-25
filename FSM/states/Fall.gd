extends State
class_name Fall

@onready var player : Player = $"../.."

func stateEnter():
	player.gravity = 100
	player.can_jump = false
	
func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func transitions():
	if player.is_on_floor():
		state_transition.emit(self, "Idle")

	if not player.is_on_floor() and not player.coyote_timer.is_stopped() and Input.is_action_pressed("up"):
		state_transition.emit(self, "Jump")
	
	if Input.is_action_just_pressed("primary attack") \
	and not player.is_on_floor() and player.can_arial_attack:
		state_transition.emit(self, "ArialAttack")
