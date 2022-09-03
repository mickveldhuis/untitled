extends PlayerState


export (float) var dash_duration = 0.1
export (float) var dash_multiplier = 3.0


var dash_direction : Vector2 = Vector2.ZERO


onready var timer : Timer = $DashTimer
onready var particles : Particles2D = $DashParticles


func enter(_data : Dictionary = {}) -> void:
	dash_direction = get_input_vector()

	particles.restart()

	timer.wait_time = dash_duration
	timer.start()

	player.anim_fsm.travel("Idle") # TODO: proper dash animation..!!


func exit() -> void:
	pass

func physics_process(_delta : float) -> void:
	player.anim_tree.set("parameters/Idle/blend_position", -player.get_mouse_vector())

	var dash_speed : float = player.speed * dash_multiplier
	player.velocity = dash_direction * dash_speed
	
	player.move()


func _on_timer_timeout() -> void:
	timer.stop()

	if is_equal_approx(player.velocity.length(), 0.0):
		emit_signal("finished", "Idle")
	
	emit_signal("finished", "Run")
