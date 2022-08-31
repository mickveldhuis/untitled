extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	print("[Enter Action] Interact state...")

	player.velocity = Vector2.ZERO


func exit() -> void:
	print("[Exit Action] Interact state...")


func physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("Player interacts..!")
		
		yield(get_tree().create_timer(1.0), "timeout")

		emit_signal("finished", "Idle")
