extends KinematicBody2D


signal destroyed


# var impuls : float
# var direction : Vector2
var velocity : Vector2 = Vector2.ZERO
var distance : float = 100.0


func init(position : Vector2, initial_velocity : Vector2, max_distance : float = 200) -> void:
	global_position = position
	
	distance = max_distance
	velocity = initial_velocity


func _physics_process(delta: float) -> void:
	var dx : Vector2 = velocity * delta 
	var collision = move_and_collide(dx)

	distance -= dx.length()

	if collision or distance <= 0:
		destroy()


func destroy() -> void:
	queue_free()

	emit_signal("destroyed")


func _on_screen_exited() -> void:
	destroy()
