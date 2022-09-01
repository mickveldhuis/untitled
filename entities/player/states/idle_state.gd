extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO


func exit() -> void:
	pass


func handle_input() -> void:
	if (Input.is_action_just_pressed("move_down") 
		or Input.is_action_just_pressed("move_up")
		or Input.is_action_just_pressed("move_left")
		or Input.is_action_just_pressed("move_right")):
		emit_signal("finished", "Run")
	elif Input.is_action_just_pressed("dash"):
		emit_signal("finished", "Dash")