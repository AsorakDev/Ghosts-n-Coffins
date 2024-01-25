extends CharacterBody2D
class_name Player

@onready var el_marker = $Markers/ElMarker
@onready var peko_marker = $Markers/PekoMarker
@onready var puyo_marker = $Markers/PuyoMarker
@onready var arial_marker_left = $Markers/ArialMarkerLeft
@onready var arial_marker_right = $Markers/ArialMarkerRight

@onready var hurtbox_standing = $HurtboxStanding
@onready var hurtbox_crouching = $HurtboxCrouching

@onready var primary_attack_timer = $Timers/PrimaryAttackTimer
@onready var arial_attack_spawn_timer = $Timers/ArialAttackSpawnTimer
@onready var arial_attack_timer = $Timers/ArialAttackTimer
@onready var swap_weapon_timer = $Timers/SwapWeaponTimer
@onready var swap_out_timer = $Timers/SwapOutTimer
@onready var coyote_timer = $Timers/CoyoteTimer
@onready var jump_timer = $Timers/JumpTimer
@onready var slide_timer = $Timers/SlideTimer

@export var hit_points : int
#hit_points == 3, Peko, Puyo, El
#hit_points == 2, Peko, El
#hit_points == 1, El
#hit_points == 0, DIE

@export var move_speed : float
@export var acceleration : float
@export var max_fall_speed : float
@export var jump_speed : float
@export var gravity : float

var direction : Vector2 
var facing_direction : float = 1

var lock_direction: bool = false
var alter_move : bool = false
var can_arial_attack : bool = true
var can_attack : bool = true
var can_swap : bool = true
var can_jump : bool = true

var current_weapon : String
var primary_weapon : String
var secondary_weapon : String 

func _ready():
	primary_weapon = "Revolver"
	secondary_weapon = "B"
	current_weapon = primary_weapon

func _physics_process(_delta):
	move()
	get_direction()
	apply_gravity()
	handle_health()
	move_and_slide()

func get_direction():
	if not lock_direction:
		direction = Input.get_vector("left", "right", "up", "down")
		
		if direction.x > 0:
			direction.x = 1
		
		elif direction.x < 0:
			direction.x = -1
		
		if direction.x != 0:
			facing_direction = direction.x 
	
func move():
	if not alter_move:
		velocity.x = move_toward(velocity.x, direction.x * move_speed, acceleration)

func apply_gravity():
	if velocity.y < max_fall_speed:
		velocity.y += gravity
	
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed

func handle_health():
	if hit_points == 3:
		pass
	
	elif hit_points == 2:
		pass
	
	elif hit_points == 1:
		pass
	
	elif hit_points == 0:
		die()

func die():
	pass
