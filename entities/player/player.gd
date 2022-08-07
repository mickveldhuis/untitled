extends KinematicBody2D

export(int) var speed = 100
export(int) var acceleration = 450
export(int) var friction = 300
export(int) var interaction_dist = 32


enum PlayerState {
	MOVE,
	ATTACK,
	INTERACT,
}

var state : int = PlayerState.MOVE setget set_state, get_state
var velocity : Vector2 = Vector2.ZERO


onready var anim : AnimationPlayer = $AnimationPlayer
onready var hitbox : Area2D = $Weapon/Hitbox
onready var timer : Timer = $Timer


func _ready() -> void:
	pass


func _process (delta):
	pass


func _physics_process(delta):
	match state:
		PlayerState.MOVE:
			move_state(delta)
		
		PlayerState.INTERACT:
			interact_state(delta)

		PlayerState.ATTACK:
			attack_state(delta)

	
func move_state(delta : float) -> void:
	var input_vector : Vector2  = get_input_vector()
	velocity = input_vector * speed
	
#   DEPRECATED... Movement code...
#	if input_vector.length() != 0:
#		velocity = velocity.move_toward(speed * input_vector, acceleration * delta)
#	else:
#		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("interact"):
		interact()
	elif Input.is_action_just_pressed("action"):
		if timer.is_stopped():
			print("ATTACCCKK!!")
			if not anim.is_playing():
				anim.play("spear")
				timer.start() # timeout attacking ability!
			if anim.current_animation == "spear":
				for area in hitbox.get_overlapping_areas():
					if area.has_method("on_hit"):
						area.on_hit(self, {})
		
#		if ray_cast.is_colliding() and timer.is_stopped():
#			print("HIT DUMMY...!!!")
#
#			timer.start()
#
#			var rc_collider = ray_cast.get_collider()
#
#			if rc_collider.has_method("on_hit"):
#				rc_collider.on_hit(self, {})	


func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if input_vector.x != 0 and input_vector.y != 0:
		input_vector.y /= 2
	
	input_vector = input_vector.normalized()
	
	return input_vector

func move() -> void:
	velocity = move_and_slide(velocity)


func attack_state(delta) -> void:
	velocity = Vector2.ZERO


func interact_state(delta) -> void:
	velocity = Vector2.ZERO


func interact() -> void:
	pass


func _on_timer_timeout() -> void:
	timer.stop()


func set_state(next_state : int) -> void:
	state = next_state


func get_state() -> int:
	return state
