extends Node2D


var enemies_loc : NodePath = "YSort/Enemies"


onready var spawn_position : Position2D = $Position
onready var timer : Timer = $Timer


func _ready() -> void:
	spawn_dummy()


func spawn_dummy() -> void:
	var dummy : StaticBody2D = ResourceManager.enemies["dummy"].instance()
	dummy.global_position = spawn_position.global_position
	
	var _err : int = dummy.connect("destroyed", self, "_on_dummy_destroyed")

	var level = get_tree().current_scene
	level.get_node(enemies_loc).add_child(dummy)


func _on_dummy_destroyed() -> void:
	timer.start()	


func _on_timer_timeout() -> void:
	timer.stop()

	call_deferred("spawn_dummy")