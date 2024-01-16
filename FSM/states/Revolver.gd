extends State
class_name Revolver

@onready var tap_shot = preload("res://weapons/revolver/revolver_tap_projectile.tscn")
@onready var mash_shot = preload("res://weapons/revolver/revolver_mash_projectile.tscn")

@onready var player : Player = $"../.."
@onready var revolver_tap_timer = $"../../Timers/RevolverTapTimer"
@onready var revolver_mash_timer = $"../../Timers/RevolverMashTimer"
@onready var revolver_cool_down = $"../../Timers/RevolverCoolDown"

var can_tap : bool = true
var can_mash : bool = false
var can_exit : bool = false
var shots_fired : int
var deleted_shots : int
# Shoot up to six times
# On cooldown until last bullet is gone plus one second

func stateEnter():
	if can_tap:
		tap()
	
	elif can_mash:
		mash()
		
func stateUpdate(_delta):
	if can_mash and Input.is_action_just_pressed("shoot"):
		mash()
		
	transitions()

func stateExit():
	player.alter_move = false
	can_exit = false

func transitions():
	if revolver_tap_timer.is_stopped() and player.is_on_floor() and player.direction.x == 0:
		state_transition.emit(self, "Idle")
		
	if revolver_tap_timer.is_stopped() and player.is_on_floor() and player.direction.x != 0:
		state_transition.emit(self, "Walk")

func tap():
	shoot()
	can_tap = false
	can_mash = true
	
func mash():
	if shots_fired < 5:
		shots_fired += 1
		shoot()

func shoot():
	revolver_tap_timer.start()
	revolver_mash_timer.start()
	player.alter_move = true
	player.velocity.x = 0
	
	var revolver_projectile : Area2D
	
	if can_tap:
		revolver_projectile = tap_shot.instantiate() as Area2D

	elif can_mash:
		revolver_projectile = mash_shot.instantiate() as Area2D
	
	revolver_projectile.position = player.global_position
	$"../../Projectiles".add_child(revolver_projectile)
		
func _on_revolver_mash_timer_timeout():
	can_tap = true
	can_mash = false

func _on_projectiles_child_exiting_tree(node : RevolverMashProjectile):
	deleted_shots += 1
	if deleted_shots == 5:
		revolver_cool_down.start()
		
func _on_revolver_cool_down_timeout():
	deleted_shots = 0
	shots_fired = 0
