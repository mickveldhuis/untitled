class_name Projectile
extends Node2D


signal destroyed


var velocity : Vector2 = Vector2.ZERO
var distance : float = 100.0


func init(position : Vector2, initial_velocity : Vector2, rot_angle : float = 0, max_distance : float = 200) -> void:
	global_position = position
	rotation_degrees = rot_angle
	
	distance = max_distance
	velocity = initial_velocity


func _physics_process(delta: float) -> void:
	var dx : Vector2 = velocity * delta 
	global_position += dx

	distance -= dx.length()

	if distance <= 0:
		destroy()


func destroy() -> void:
	queue_free()

	emit_signal("destroyed")
