extends StaticBody2D


signal destroyed


var health : float = 100.0


onready var sprite : Sprite = $Sprite
onready var collider : CollisionShape2D = $CollisionShape2D
onready var health_bar : Control = $HealthBar
onready var flash_timer : Timer = $FlashTimer	


func _ready() -> void:
	sprite.material.set_shader_param("is_white", false) # TODO: remove... dunno why this is required..?
	
	health_bar.set_max(health)

	var _err : int = flash_timer.connect("timeout", self, "_on_flash_timer_timeout")


func take_damage(damage : int) -> void:
	health -= damage
	health_bar._update(health)

	if health <= 0:
		flash_timer.stop()
		emit_signal("destroyed")

		queue_free()
	
	flash_timer.start()
	sprite.material.set_shader_param("is_white", true)



func _on_flash_timer_timeout() -> void:
	sprite.material.set_shader_param("is_white", false)

	flash_timer.stop()
