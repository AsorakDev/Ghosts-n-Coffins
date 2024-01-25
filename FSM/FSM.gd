extends Node
class_name FSM

@export var inital_state : State
@onready var player : Player = $".."
var states : Dictionary
var current_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	
	if inital_state:
		current_state = inital_state
		current_state.stateEnter()
	
func _process(delta):
	if current_state:
		current_state.stateUpdate(delta)
		
	$"../DEBUG".text = current_state.name + "\n" + str(player.velocity.x) + "\n" + str(player.velocity.y) + "\n" + str(player.facing_direction)

func change_state(old_state: State, new_state_name : String):
	if old_state != current_state:
		print("Invalid change_state trying from: " + old_state.name + "\nBut currently in: " + current_state.name) 
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
	
	if current_state:
		current_state.stateExit()
	
	current_state = new_state
	current_state.stateEnter()
