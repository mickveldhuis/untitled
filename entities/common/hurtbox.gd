extends Area2D


signal hurtbox_hit(body, data)


func on_hit(body : KinematicBody2D, hit_data : Dictionary) -> void:
	emit_signal("hurtbox_hit", body, hit_data)
