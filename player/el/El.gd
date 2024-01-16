extends CharacterBody2D
class_name Player

@onready var projectiles : Node = $Projectiles

#@onready var revolver = $FSM/Revolver
#@onready var shotgun = $FSM/Shotgun
#@onready var sniper = $FSM/Sniper
#@onready var knife = $FSM/Knife
#@onready var rpg = $FSM/RPG

@onready var swap_weapon_timer = $Timers/SwapWeaponTimer
@onready var swap_out_timer = $Timers/SwapOutTimer
@onready var coyote_timer = $Timers/CoyoteTimer
@onready var jump_timer = $Timers/JumpTimer

@export var move_speed : float
@export var acceleration : float
@export var max_fall_speed : float
@export var jump_speed : float
@export var gravity : float

var direction : Vector2 

var alter_move : bool = false
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
	change_weapon()
	get_direction()
	apply_gravity()
	move_and_slide()

func get_direction():
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x > 0:
		direction.x = 1
	
	elif direction.x < 0:
		direction.x = -1
	
func move():
	if not alter_move:
		velocity.x = move_toward(velocity.x, direction.x * move_speed, acceleration)

func apply_gravity():
	if velocity.y < max_fall_speed:
		velocity.y += gravity
	
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed

func change_weapon():
	if Input.is_action_just_pressed("swap"):
		if current_weapon == primary_weapon and can_swap:
			current_weapon = secondary_weapon
			can_swap = false
			swap_weapon_timer.start()
			
		elif current_weapon == secondary_weapon and can_swap:
			current_weapon = primary_weapon
			can_swap = false
			swap_weapon_timer.start()
	
	if swap_weapon_timer.is_stopped():
		can_swap = true
