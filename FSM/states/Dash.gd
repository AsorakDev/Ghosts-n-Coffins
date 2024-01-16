extends State
class_name Dash

@onready var player : Player = $"../.."
@onready var hurtbox_standing = $"../../HurtboxStanding"
@onready var hurtbox_crouching = $"../../HurtboxCrouching"

@onready var old_move_speed : float = player.move_speed
@onready var old_acceleration : float = player.acceleration

var dash_acceleration = 100
var dash_speed = 1200

func stateEnter():
	player.move_speed = dash_speed
	player.acceleration = dash_acceleration

func stateUpdate(_delta):
	transitions()

func stateExit():
	hurtbox_standing.disabled = false
	hurtbox_crouching.disabled = true
	player.move_speed = old_move_speed
	player.acceleration = old_acceleration
	
func transitions():
	if Input.is_action_just_released("down"):
		state_transition.emit(self, "Idle")
		
	if player.velocity.x == 0 and not Input.is_action_just_released("down"):
		state_transition.emit(self, "Crouch")
		
	if  player.direction.x != 0 and not player.is_on_floor():
		state_transition.emit(self, "Fall")
