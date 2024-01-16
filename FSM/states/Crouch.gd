extends State
class_name Crouch

@onready var player : Player = $"../.."
@onready var hurtbox_standing = $"../../HurtboxStanding"
@onready var hurtbox_crouching = $"../../HurtboxCrouching"

func stateEnter():
	pass

func stateUpdate(_delta):
	crouch()
	transitions()

func stateExit():
	pass

func crouch():
	hurtbox_crouching.disabled = false
	hurtbox_standing.disabled = true

func transitions():
	if Input.is_action_just_released("down"):
		hurtbox_crouching.disabled = true
		hurtbox_standing.disabled = false
		state_transition.emit(self, "Idle")
	
	if not player.is_on_floor and not Input.is_action_just_released("down"):
		hurtbox_crouching.disabled = true
		hurtbox_standing.disabled = false
		state_transition.emit(self, "Fall")
	
	if player.direction.x != 0 and not Input.is_action_just_released("down"):
		state_transition.emit(self, "Dash")
