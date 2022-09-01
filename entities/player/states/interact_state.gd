extends PlayerState


func enter(_data : Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO


func exit() -> void:
	pass


func physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("Player interacts..!")
		
		yield(get_tree().create_timer(1.0), "timeout")

		emit_signal("finished", "Idle")
