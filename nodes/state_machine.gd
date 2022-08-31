class_name StateMachine
extends Node2D


signal state_changed(previous, new)


export var initial_state : NodePath = NodePath()


var state_id : String


onready var state : State = get_node(initial_state)


func init() -> void:
	state_id = state.name

	for child in get_children():
		if child is State:
			child.connect("finished", self, "change_state")

	state.enter()


func handle_input() -> void:
	state.handle_input()


func process(delta : float) -> void:
	state.process(delta)


func physics_process(delta : float) -> void:
	state.physics_process(delta)


func change_state(next_state_id : String) -> void:
	var prev_state : State = state
	
	if not has_node(next_state_id):
		return
	
	if state:
		state.exit()
	
		state_id = next_state_id

	state = get_node(next_state_id)
	state.enter()
	
	emit_signal("state_changed", prev_state.name, state.name)
