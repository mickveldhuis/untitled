extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass


func handle_input() -> void:
	if player.fsm.state_id != "Dash":
		if Input.is_action_just_pressed("action"):
			emit_signal("finished", "PrimaryAttack")
		elif Input.is_action_just_pressed("secondary"):
			emit_signal("finished", "SecondaryAttack")
		elif Input.is_action_just_pressed("interact"):
			emit_signal("finished", "Interact")
