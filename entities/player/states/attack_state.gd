extends PlayerState


onready var timer : Timer = $AttackTimer


func enter(_data : Dictionary = {}) -> void:
	player.anim.play("spear")


func exit() -> void:
	pass


func physics_process(_delta : float) -> void:	
	# if timer.is_stopped():
	# 	if Input.is_action_just_pressed("action") and not player.anim.is_playing():
	# 		player.anim.play("spear")
	# 		timer.start()
	# 	else:
	# 		emit_signal("finished", "Idle")

	if player.anim.current_animation != "spear":
		if Input.is_action_just_pressed("action"):
			player.anim.play("spear")
		else:
			emit_signal("finished", "Idle")


func _on_timer_timeout() -> void:
	timer.stop()
