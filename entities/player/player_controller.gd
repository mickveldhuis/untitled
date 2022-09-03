extends KinematicBody2D


export(int) var speed = 100
export(int) var mouse_deadzone = 10


var velocity : Vector2 = Vector2.ZERO
var aim : float = 0.0
var dir_flag : String = "SE"


const ISO_ANGLE : float = 26.57


# Expose state activity to all 'state machines'
# var is_idle : bool = false
# var is_running : bool = false
# var is_dashing : bool = false
# var is_attacking : bool = false
# var is_interacting : bool = false


onready var fsm : StateMachine = $States
onready var action_fsm : StateMachine = $ActionStates
onready var anim : AnimationPlayer = $AttackPlayer
onready var anim_tree : AnimationTree = $AnimationTree
onready var anim_fsm : AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")
onready var weapon : Node2D = $Weapon
onready var hitbox : Area2D = $Weapon/WeaponSprite/HitBox
onready var com : Position2D = $COM


func _ready() -> void:
	fsm.init()
	action_fsm.init()


func _unhandled_input(_event: InputEvent) -> void:
	pass


func _process (delta):
	fsm.process(delta)
	action_fsm.process(delta)


func _physics_process(delta):
	fsm.handle_input()
	action_fsm.handle_input()

	fsm.physics_process(delta)
	action_fsm.physics_process(delta)

	# Update the weapon and player animations
	update_aim()
	weapon.rotation_degrees = aim


# func update_anim() -> void:
# 	var anim_prefix : String = "idle"

# 	if fsm.state_id == "Run":
# 		anim_prefix = "run"

# 	var anim_name : String = "{prefix}_{flag}".format({"prefix": anim_prefix, "flag": dir_flag})
# 	anim_.play(anim_name)


func update_aim() -> void:
	var mouse_pos : Vector2 = get_mouse_vector()

	if mouse_pos.length() > mouse_deadzone:
		aim = fmod(rad2deg(mouse_pos.angle()) + 360, 360)

		if is_between(aim, 10, 60):
			dir_flag = "SE"
		elif is_between(aim, 60, 120):
			dir_flag = "S"
		elif is_between(aim, 120, 170):
			dir_flag = "SW"
		elif is_between(aim, 170, 190):
			dir_flag = "W"
		elif is_between(aim, 190, 240):
			dir_flag = "NW"
		elif is_between(aim, 240, 300):
			dir_flag = "N"
		elif is_between(aim, 300, 350):
			dir_flag = "NE"
		else:
			dir_flag = "E"


func is_between(val : float, a : float, b : float) -> bool:
	return val >= a and val < b


func get_mouse_vector() -> Vector2:
	var mouse : Vector2 = com.get_local_mouse_position()

	return mouse


func move() -> void:
	velocity = move_and_slide(velocity)
