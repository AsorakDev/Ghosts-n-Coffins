extends State
class_name Idle

@onready var player : Player = $"../.."

func stateEnter():
	player.alter_move = false
	player.can_jump = true
	player.can_arial_attack = true
	player.gravity = 300
	
func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func transitions():
	if player.direction.x != 0 and player.is_on_floor():
		state_transition.emit(self, "Walk")
		
	if player.direction.x == 0 and Input.is_action_pressed("down"):
		state_transition.emit(self, "Crouch")
		
	if player.direction.x == 0 and Input.is_action_just_pressed("up"):
		state_transition.emit(self, "Jump")
		
	if player.direction.x == 0 and not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
	
	if player.direction.x == 0 and Input.is_action_pressed("primary attack"):
		state_transition.emit(self, "PrimaryAttack")
