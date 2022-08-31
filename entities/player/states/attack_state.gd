extends PlayerState


onready var timer : Timer = $AttackTimer


func enter(_data : Dictionary = {}) -> void:
	print("[Enter Action] Attack state...")


func exit() -> void:
	print("[Exit Action] Attack state...")


func physics_process(_delta : float) -> void:	
	if timer.is_stopped():
		print("AATTAACCKK!!")
		if Input.is_action_just_pressed("action") and not player.anim.is_playing():
			player.anim.play("spear")
			timer.start()
		else:
			emit_signal("finished", "Idle")


func _on_timer_timeout() -> void:
	timer.stop()
