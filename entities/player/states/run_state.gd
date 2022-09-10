extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	player.anim_fsm.travel("Run")


func exit() -> void:
	pass


func physics_process(_delta : float) -> void:
	player.update_blend_position("Run")

	var input_vector : Vector2  = get_input_vector()
	player.velocity = input_vector * player.speed
	
	player.move()

	# if is_equal_approx(player.velocity.length(), 0.0):
	# 	emit_signal("finished", "Idle")
	if player.velocity.is_equal_approx(Vector2.ZERO):
		emit_signal("finished", "Idle")
	elif Input.is_action_just_pressed("dash"):
		emit_signal("finished", "Dash")
