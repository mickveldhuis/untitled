class_name PlayerState
extends State


onready var player : KinematicBody2D = owner


func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if input_vector.x != 0 and input_vector.y != 0:
		input_vector.y /= 2
	
	input_vector = input_vector.normalized()
	
	return input_vector