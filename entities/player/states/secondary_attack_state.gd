extends PlayerState


export var projectile_speed : float = 100
export var cooldown : float = 0.5


var is_destroyed : bool = false


onready var spawn : Position2D = $SpawnPosition
onready var timer : Timer = $CooldownTimer


func enter(_data : Dictionary = {}) -> void:
	var spear : KinematicBody2D = ResourceManager.projectiles["spear"].instance()

	var vel : Vector2 = projectile_speed * Vector2.RIGHT.rotated(deg2rad(player.aim))
	spear.init(spawn.global_position, vel, player.aim, 200)
	
	var _err : int = spear.connect("destroyed", self, "_on_destroyed")

	var level = get_tree().current_scene
	level.get_node("YSort/Projectiles").add_child(spear)

	toggle_weapon()

	timer.wait_time = cooldown


func exit() -> void:
	toggle_weapon()

	is_destroyed = false


func physics_process(_delta : float) -> void:
	if is_destroyed and timer.is_stopped():
		emit_signal("finished", "Idle")


func toggle_weapon() -> void:
	player.weapon.visible = !player.weapon.visible


func _on_destroyed() -> void:
	timer.start()

	is_destroyed = true


# func _on_timer_timeout() -> void:
# 	timer.stop()
