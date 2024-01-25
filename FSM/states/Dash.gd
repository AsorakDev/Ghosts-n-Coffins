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
	dash()

func stateUpdate(_delta):
	transitions()

func stateExit():
	player.alter_move = false
	player.lock_direction = false
	hurtbox_standing.disabled = false
	hurtbox_crouching.disabled = true
	player.move_speed = old_move_speed
	player.acceleration = old_acceleration
	
func transitions():
	if player.dash_timer.is_stopped() or Input.is_action_just_released("left") \
		or Input.is_action_just_released("right") or Input.is_action_just_released("down"):
		state_transition.emit(self, "Idle")

func dash():
	player.lock_direction = true
	player.alter_move = true
	player.dash_timer.start()
	
	if Input.is_action_just_pressed("right"):
		player.velocity.x = 1600
	
	if Input.is_action_just_pressed("left"):
		player.velocity.x = -1600
