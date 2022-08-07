extends StaticBody2D


var hit_text : String = "Hits: {count}"
var n_hits : int = 0


onready var collider : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	update_counter_text()


func _on_dummy_hit(body, data) -> void:
	print("on_dummy_hit")
	n_hits += 1
	
	update_counter_text()


func why_does_this_work_this_way():
	print("WHY!!!")


func update_counter_text() -> void:
	$HitCounter.text = hit_text.format({"count": n_hits})
