extends State
class_name Slide

@onready var player : Player = $"../.."
var can_exit : bool = false

func stateEnter():
	slide()

func stateUpdate(_delta):
	transitions()

func stateExit():
	player.hurtbox_standing.disabled = false
	player.hurtbox_crouching.disabled = true

func transitions():
	if player.slide_timer.is_stopped() or Input.is_action_just_released("left") \
	or Input.is_action_just_released("right"):
		if player.is_on_floor():
			if player.direction.x == 0:
				state_transition.emit(self, "Idle")
			
			if player.direction.x != 0:
				state_transition.emit(self, "Walk")
			
			player.alter_move = false
		
	if not player.is_on_floor() and player.velocity.y > 0:
		state_transition.emit(self, "Fall")
		player.coyote_timer.start()
	
	if player.is_on_floor() and Input.is_action_just_pressed("up"):
		state_transition.emit(self, "Jump")
			

func slide():
	player.alter_move = true
	player.hurtbox_standing.disabled = true
	player.hurtbox_crouching.disabled = false
	player.slide_timer.start()
	player.velocity.x = 1200 * player.direction.x
	player.gravity = 50
