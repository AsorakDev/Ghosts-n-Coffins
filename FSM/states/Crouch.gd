extends State
class_name Crouch

@onready var player : Player = $"../.."

func stateEnter():
	crouch()

func stateUpdate(_delta):
	transitions()

func stateExit():
	pass

func crouch():
	player.alter_move = true
	player.velocity.x = 0
	player.hurtbox_crouching.disabled = false
	player.hurtbox_standing.disabled = true

func transitions():
	if player.is_on_floor():
		if Input.is_action_just_released("down"):
			state_transition.emit(self, "Idle")
			player.hurtbox_crouching.disabled = true
			player.hurtbox_standing.disabled = false
			
		if Input.is_action_just_pressed("left"):
			player.direction.x = -1
			state_transition.emit(self, "Slide")
			
		elif Input.is_action_just_pressed("right"):
			player.direction.x = 1
			state_transition.emit(self, "Slide")
		
	if not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
		player.hurtbox_crouching.disabled = true
		player.hurtbox_standing.disabled = false
