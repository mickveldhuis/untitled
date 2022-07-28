extends KinematicBody2D

export(int) var speed = 100
export(int) var acceleration = 450
export(int) var friction = 300
export(int) var interaction_dist = 10


var velocity : Vector2 = Vector2.ZERO


onready var ray_cast : RayCast2D = $RayCast2D


func _ready() -> void:
	pass


func _process (delta):
	pass


func _physics_process(delta):
	move_state(delta)

	
func move_state(delta : float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = -(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	input_vector = input_vector.normalized()
	
#	var iso_input : Vector2 = input_vector
	var iso_input : Vector2 = isometric_input(input_vector)
	
	if input_vector.length() != 0:
		velocity = velocity.move_toward(speed * iso_input, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("interact"):
		interact()


func isometric_input(vec : Vector2) -> Vector2:
	return Vector2(vec.x + vec.y, (vec.x - vec.y)/2)

func action_state(delta) -> void:
	velocity = Vector2.ZERO


func interact_state(delta) -> void:
	pass


func move() -> void:
	velocity = move_and_slide(velocity)


func interact() -> void:
	pass


func update_raycast_position() -> void:
	var mouse_dir = ray_cast.global_position - get_global_mouse_position()
	mouse_dir = mouse_dir.normalized()
	
	ray_cast.cast_to = mouse_dir * interaction_dist


#func set_state(next_state : int) -> void:
#	state = next_state
#
#
#func get_state() -> int:
#	return state
