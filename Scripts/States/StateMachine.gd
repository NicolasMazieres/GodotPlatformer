extends Node

@onready var initial_state: State = $PlayerIdle
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter_state()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update_state(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update_state(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit_state()
	
	new_state.enter_state()
	current_state = new_state
