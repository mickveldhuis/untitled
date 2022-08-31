extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	print("[Enter] Run state...")


func exit() -> void:
	print("[Exit] Run state...")


func physics_process(_delta : float) -> void:
	var input_vector : Vector2  = get_input_vector()
	player.velocity = input_vector * player.speed
	
	player.move()

	# if is_equal_approx(player.velocity.length(), 0.0):
	# 	emit_signal("finished", "Idle")
	if player.velocity.is_equal_approx(Vector2.ZERO):
		emit_signal("finished", "Idle")
	elif Input.is_action_just_pressed("dash"):
		emit_signal("finished", "Dash")
