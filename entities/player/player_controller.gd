extends KinematicBody2D


export(int) var speed = 100


var velocity : Vector2 = Vector2.ZERO

# Expose state activity to all 'state machines'
# var is_idle : bool = false
# var is_running : bool = false 
# var is_dashing : bool = false
# var is_attacking : bool = false
# var is_interacting : bool = false


onready var fsm : StateMachine = $States
onready var action_fsm : StateMachine = $ActionStates
onready var anim : AnimationPlayer = $AnimationPlayer
onready var weapon : Node2D = $Weapon
onready var hitbox : Area2D = $Weapon/WeaponSprite/HitBox


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


func move() -> void:
	velocity = move_and_slide(velocity)
