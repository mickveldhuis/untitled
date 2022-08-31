extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	print("[Enter Action] Idle state...")


func exit() -> void:
	print("[Exit Action] Idle state...")


func handle_input() -> void:
	if player.fsm.state_id != "Dash":
		if Input.is_action_just_pressed("action"):
			emit_signal("finished", "Attack")
		elif Input.is_action_just_pressed("interact"):
			emit_signal("finished", "Interact")
