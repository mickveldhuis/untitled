extends Control

onready var health_b = $BottomIndicator
onready var health_t = $TopIndicator
# onready var health_bar : TextureProgress = $Health
onready var tween : Tween = $Tween


# func _on_health_updated(health : float, amount : float) -> void:
func _update(health : float) -> void:
	health_t.value = health

	tween.interpolate_property(health_b, "value", health_b.value, health, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.1)
	tween.start()


# func _on_max_health_updated(max_health : float) -> void:
func set_max(max_health : float) -> void:
	health_t.max_value = max_health
	health_b.max_value = max_health