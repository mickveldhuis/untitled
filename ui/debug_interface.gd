extends Control

onready var player : KinematicBody2D = get_node("/root/ThroneRoom/YSort/Player")
onready var state_label : Label = $StateInfo/VBoxContainer/StateLabel
onready var action_label : Label = $StateInfo/VBoxContainer/ActionStateLabel

func _ready() -> void:
	var _err : int = player.fsm.connect("state_changed", self, "_on_fsm_updated")
	var _err_2 : int = player.action_fsm.connect("state_changed", self, "_on_action_fsm_updated")

	state_label.text = "Player state: {name}".format({"name": player.fsm.state_id})
	action_label.text = "Action state: {name}".format({"name": player.action_fsm.state_id})

func _on_fsm_updated(_previous : String, new : String) -> void:
	state_label.text = "Player state: {name}".format({"name": new})

func _on_action_fsm_updated(_previous : String, new : String) -> void:
	action_label.text = "Action state: {name}".format({"name": new})
